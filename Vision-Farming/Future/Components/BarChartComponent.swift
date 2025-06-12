//
//  BarChartComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/18/25.
//

import SwiftUI
import Charts

struct BarChartComponent: View {
    
    public let label : String
    @State private var currentTab: String = "Monthly"
    @State private var selectedValue: SensorHistory?
    @State public var sensorHistory: [SensorHistory] = generateChartData(forInterval: "Monthly")
    
    var body: some View {
        VStack{
            HStack{
                Text(label)
                    .font(.headline)
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
                            .fontWeight(.medium)
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                    }
                }
                .padding(5)
                .tint(.black)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.vertical,10)
            Chart(sensorHistory) { point in
                BarMark(
                    x: .value("", point.timestamp),
                    y: .value("", point.value),
                    width: .fixed(5)
                )
                .foregroundStyle(.green)
            }
            .chartYAxis{
                AxisMarks(
                    format: Decimal.FormatStyle.Percent.percent.scale(1),
                    values: [0,25,50,75,100]
                )
            }
            .chartXAxis {
                AxisMarks{
                    AxisValueLabel(format: .dateTime.day(.twoDigits))
                    AxisGridLine()
                    AxisTick()
                }
            }
        }
    }
}

#Preview {
    BarChartComponent(label: "")
}
