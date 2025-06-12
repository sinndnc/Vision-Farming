//
//  BudgetComponent.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/21/25.
//

import SwiftUI
import Charts

struct BudgetComponent: View {
    
    @State private var selected : String = "Jan 25"
    
    var body: some View {
        VStack{
            HStack(spacing:30){
                Menu{
                    Picker("",selection: $selected) {
                        Text("Fab")
                        Text("Mar")
                        Text("Apr")
                        Text("May")
                        Text("Jun")
                        Text("Jul")
                        Text("Aug")
                        Text("Sep")
                    }
                } label: {
                    Text(selected)
                        .font(.title2)
                        .fontWeight(.medium)
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .tint(.black)
                Spacer()
                Text("Income")
                    .font(.caption)
                Text("Expense")
                    .font(.caption)
            }
            BarChartComponent(label:"")
                .padding()
        }
        .padding(.vertical)
    }
}

#Preview {
    BudgetComponent()
}
