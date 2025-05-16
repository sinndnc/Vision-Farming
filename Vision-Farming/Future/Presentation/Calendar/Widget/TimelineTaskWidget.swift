//
//  TimelineTaskView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/17/25.
//


import SwiftUI

struct TimelineTaskWidget: View {
    
    var geo : GeometryProxy
    @State var reminder : Reminder
    @State var isPresented : Bool = false
    
    var body: some View {
        let width = geo.size.width * 0.8
        let height = geo.size.height * 0.1 * 200
        
        HStack(alignment: .center){
            Rectangle()
                .frame(width: 2)
                .foregroundStyle(.pink)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack(alignment: .leading) {
                Text(reminder.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                Spacer()
                Text("")
                    .font(.caption2)
                    .foregroundStyle(.white)
            }
            Spacer()
            Image(systemName: "info.circle")
                .foregroundStyle(.white)
        }
        .zIndex(1)
        .padding(.vertical,5)
        .padding(.horizontal,10)
        .frame(width: width,height: height)
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .sheet(isPresented: $isPresented, content: {
          
        })
        .onTapGesture { isPresented.toggle() }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        TimelineTaskWidget(
            geo: geometry,
            reminder: Reminder(
                title: "Practice with neptün",
                notes: "don't forget to get the balss",
                tags: ["Dental","Tennis"]
            )
        )
    })
}
