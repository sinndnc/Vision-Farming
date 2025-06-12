//
//  FinanceView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/17/25.
//

import SwiftUI
import Charts

struct BudgetView: View {
    
    @StateObject var viewModel: BudgetViewModel
    
    var body: some View {
        GeometryReader{ geoProxy in
            NavigationStack{
                List{
                    Section{
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Income: ₺\(viewModel.totalIncome, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                    Text("Expense: ₺\(viewModel.totalExpense, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                }
                                Spacer()
                                Picker("", selection: $viewModel.selectedSeason) {
                                    ForEach(Season.allCases, id: \.self) { season in
                                        Text(season.rawValue.capitalized).tag(Optional(season))
                                    }
                                }
                                .pickerStyle(.menu)
                                .padding(.horizontal)
                                
                               
                            }
                            
                            if viewModel.filteredTransactions.isEmpty{
                                Chart(TransactionType.allCases ){ type in
                                    SectorMark(
                                        angle: .value("", 1)
                                    )
                                    .foregroundStyle(by: .value("Category", type.rawValue.capitalized))
                                }
                                .frame(height: geoProxy.size.height * 0.25)
                            }else{
                                Chart(viewModel.filteredTransactions) { tx in
                                    SectorMark(
                                        angle: .value("\(tx.type)".uppercased(), tx.amount)
                                    )
                                    .foregroundStyle(by: .value("Category", tx.type.rawValue.capitalized))
                                }
                                .frame(height: geoProxy.size.height * 0.25)
                            }
                        }
                    }
                    Section{
                        BarChartComponent(label: "Farms")
                    }
                    Section{
                        BarChartComponent(label: "Fields")
                    }
                    Section{
                        BarChartComponent(label: "Crops")
                    }
                    Section{
                        BarChartComponent(label: "Sensors")
                    }
                }
                .navigationTitle(Text("Budget"))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    BudgetView(
        viewModel: BudgetViewModel(
            rootViewModel: RootViewModel(
                loader: MockService().mockLoader()
            )
        )
    )
}
