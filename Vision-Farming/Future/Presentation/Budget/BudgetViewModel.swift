//
//  FinanceViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/17/25.
//

import Foundation
import CoreML


final class BudgetViewModel : BaseViewModel{
    
    @Published var totalIncome: Double = 0
    @Published var totalExpense: Double = 0
    @Published var selectedSeason: Season = .all

    @Published var sensors : [Sensor] = []
    @Published var transactions: [Transaction] = []
    @Published var filteredTransactions: [Transaction] = []
    
    @Published var error : NetworkErrorCallback?
    
    init(rootViewModel : RootViewModel) {
        super.init()
        rootViewModel.$error
            .assign(to: &$error)
        rootViewModel.$sensors
            .assign(to: &$sensors)
        rootViewModel.$transactions
            .assign(to: &$transactions)
        
        $selectedSeason
            .receive(on: DispatchQueue.main)
            .sink { [weak self] test in
                Logger.log("\(test)")
                self?.applyFilter(newSeason: test)
            }
            .store(in: &cancellables)
    }
    
    private func applyFilter(newSeason : Season) {
        filteredTransactions = transactions.filter { $0.season == newSeason}
        calculateTotals(filteredTransactions)
    }
    
    private func calculateTotals(_ transactions : [Transaction]) {
        totalIncome = transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        totalExpense = transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        Logger.log("\(totalIncome), \(totalExpense)")
    }
    
    func predictYield(product: String, year: Double) -> Double? {
        guard let model = try? YieldTabularRegressor(configuration: MLModelConfiguration()) else {
            return nil
        }
        
        let input = YieldTabularRegressorInput(Item: product, Year: Int64(year))
        
        guard let output = try? model.prediction(input: input) else { return nil }
        
        return output.featureValue(for: "Value")?.doubleValue
    }
    
    
}
