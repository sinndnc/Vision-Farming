//
//  TimelineGraphicView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/17/25.
//


import SwiftUI

struct TimelineGraphicComponent: View {
    
    var geo : GeometryProxy
    @StateObject var viewModel : CalendarViewModel
    
    var body: some View {
        
        let groupedReminders = groupOverlappingReminders(viewModel.classifiedReminders[viewModel.selectedHeaderDay] ?? [])
        let sortedGroupedReminders = groupedReminders.keys.sorted(by: { $0.start_date < $1.start_date })
        
        TimelineLayout(reminders: sortedGroupedReminders) {
            TimelineHourView(geo: geo)
            TimelineDividerWidget(geo: geo)
//            TimelineNowDividerView(geo: geo)
            ForEach(sortedGroupedReminders,id:\.self) { key in
                let reminders = groupedReminders[key]!
                TimelineTaskWidget(geo: geo, reminder: reminders.first!)
            }
        }
    }
}


func rangesIntersect(_ range1: ClosedRange<Date>, _ range2: ClosedRange<Date>) -> Bool {
    return range1.overlaps(range2)
}

func groupOverlappingReminders(_ reminders: [Reminder]) -> [Reminder: [Reminder]] {
    if reminders.isEmpty { return [:] }
    
    let sortedReminders = reminders.sorted { $0.start_date < $1.start_date }
    var groupedReminders: [Reminder: [Reminder]] = [:]
    var currentGroup: [Reminder] = [sortedReminders[0]]
    
    for reminder in sortedReminders.dropFirst() {
        
        let currentRange = currentGroup.first!.start_date...currentGroup.last!.finish_date
        let nextRange = reminder.start_date...reminder.finish_date
        
        if rangesIntersect(currentRange, nextRange) {
            currentGroup.append(reminder)
        } else {
            groupedReminders[currentGroup.first!] = currentGroup
            currentGroup = [reminder]
        }
    }
    
    groupedReminders[currentGroup.first!] = currentGroup
    
    return groupedReminders
}


#Preview {
    GeometryReader(content: { geometry in
        TimelineGraphicComponent(geo: geometry, viewModel: CalendarViewModel())
    })
}
