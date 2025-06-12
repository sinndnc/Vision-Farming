//
//  ChatComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/17/25.
//

import Charts
import SwiftUI

func generateChartData(forInterval interval: String) -> [SensorHistory] {
    var data = [SensorHistory]()
    var currentDate: Date = .now
    
    var dateComponents = DateComponents()
    switch interval {
    case "Daily":
        dateComponents.hour = -24
        dateComponents.minute = -currentDate.minute
    case "Weekly":
        dateComponents.day = -7
    case "Monthly":
        dateComponents.month = -1
    case "3 Months":
        dateComponents.month = -3
    case "6 Months":
        dateComponents.month = -6
    case "Year to Now":
        dateComponents.year = -1
    default:
        dateComponents.month = -1
    }
    
    let startDate = Calendar.current.date(byAdding: dateComponents, to: currentDate)!
    currentDate = Calendar.current.date(byAdding: .minute, value: -currentDate.minute, to: currentDate)!
    
    var date = startDate
    while date <= currentDate {
        let randomValue = Double.random(in: 20...100)
        data.append(SensorHistory(value: randomValue, timestamp: date))
        date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    return data
}


struct LineChartComponent: View {
        
    @State private var currentTab: String = "Monthly"
    @State public var sensorHistory: [SensorHistory]
    @State private var selectedValue: SensorHistory?
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center) {
                HStack{
                    Text("Irrigation & Water Usage")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    Menu{
                        Picker("",selection: $currentTab) {
                            Text("Daily").tag("Daily")
                            Text("Weekly").tag("Weekly")
                            Text("Monthly").tag("Monthly")
                                .font(.subheadline)
                            Text("3 Months").tag("3 Months")
                            Text("6 Months").tag("6 Months")
                            Text("Year to Now").tag("Year to Now")
                        }
                    }label: {
                        HStack(spacing:3){
                            Text(currentTab)
                                .font(.caption)
                            Image(systemName: "chevron.down")
                                .font(.caption2)
                        }
                    }
                    .padding(5)
                    .tint(.black)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .onChange(of: currentTab) { oldValue, newValue in
//                        self.sensorHistory = generateChartData(forInterval: newValue)
//                    }
                }
                
                Chart(sensorHistory) { point in
//                    if let firstValue = sensorHistory.first {
                        LineMark(
                            x: .value("", point.timestamp),
                            y: .value("", point.value)
                        )
                        .interpolationMethod(.cardinal)
                        .lineStyle(StrokeStyle(lineWidth: 1))
                        
                        AreaMark(
                            x: .value("", point.timestamp),
                            y: .value("", point.value)
                        )
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(.blue.opacity(0.2))
//                        RuleMark(y: .value("Limit", firstPrice.value))
//                            .foregroundStyle(.white)
//                            .lineStyle(StrokeStyle(lineWidth: 0.5))
                        
//                        let selectSide = firstPrice.value < point.value
//                        AreaMark(
//                            x: .value("", point.date),
//                            yStart: .value("", selectSide ? point.value : firstPrice.value),
//                            yEnd: .value("", !selectSide ? point.value : firstPrice.value)
//                        )
//                        .interpolationMethod(.cardinal)
//                        .foregroundStyle(.blue.opacity(0.2))
//                    }
                    
                    if let selectedPoint = selectedValue {
                        RuleMark(
                            x: .value("", selectedPoint.timestamp)
                        )
                        .foregroundStyle(.black)
                        .lineStyle(StrokeStyle(lineWidth: 1))
                        
                        PointMark(
                            x: .value("Selected Date", selectedPoint.timestamp),
                            y: .value("Selected Value", selectedPoint.value)
                        )
                        .foregroundStyle(.black)
                    }
                }
                .chartOverlay { chartProxy in
                    GeometryReader{ geometry in
                        Rectangle()
                            .fill(.clear)
                            .contentShape(Rectangle())
                            .gesture(DragGesture()
                                .onChanged{ value in
                                    
                                    let origin = geometry[chartProxy.plotFrame!].origin
                                    let location = CGPoint(
                                        x: value.location.x - origin.x,
                                        y: value.location.y - origin.y
                                    )
                                    
                                    if let date : Date = chartProxy.value(atX: location.x){
                                        
                                        if let selectedValue = sensorHistory.first(where: { item in
                                            item.timestamp.day == date.day && item.timestamp.month == date.month
                                        }){
                                            self.selectedValue = selectedValue
                                        }
                                    }
                                    
                                }
                                .onEnded{ value in
                                    self.selectedValue = nil
                                }
                            )
                    }
                }
            }
        }
    }
}



#Preview {
    LineChartComponent(sensorHistory: [])
}
