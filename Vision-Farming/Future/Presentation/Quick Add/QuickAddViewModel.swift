//
//  QuickAddViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/24/25.
//

import Foundation


final class QuickAddViewModel : BaseViewModel{
    
    @Published public var farms : [Farm] = []
    @Published public var fields : [Field] = []
    
    init(rootViewModel: RootViewModel) {
        super.init()
        rootViewModel.$farms
            .assign(to: &$farms)
        rootViewModel.$fields
            .assign(to: &$fields)
        
    }
}


extension QuickAddViewModel{
    
    var addObject : [QuickAddItem] {
        [
            QuickAddItem(name: "Add Crop", image: "leaf", value: .crop),
            QuickAddItem(name: "Add Farm", image: "mountain.2", value: .farm),
            QuickAddItem(name: "Add Field", image: "tree", value: .field),
            QuickAddItem(name: "Add Sensor", image: "sensor.tag.radiowaves.forward", value: .sensor)
        ]
    }
    
    var addDocument : [QuickAddItem] {
        [
            QuickAddItem(name: "To Crop", image: "document.badge.plus", value: .crop),
            QuickAddItem(name: "To Farm", image: "document.badge.plus", value: .crop),
            QuickAddItem(name: "To Field", image: "document.badge.plus", value: .crop),
            QuickAddItem(name: "To Sensor", image: "document.badge.plus", value: .crop),
            QuickAddItem(name: "To Income", image: "document.badge.plus", value: .crop),
            QuickAddItem(name: "To Expense", image: "document.badge.plus", value: .crop)
        ]
    }
    
    var addIncome : [QuickAddItem] {
        [
            QuickAddItem(name: "Harvest Sale", image: "apple.meditate", value: .harvestSale),
            QuickAddItem(name: "Donation", image: "eurosign.bank.building", value: .donation),
            QuickAddItem(name: "Other", image: "plus", value: .otherIncome)
        ]
    }
    
    var addExpense : [QuickAddItem] {
        [
            QuickAddItem(name: "Seed", image: "leaf", value: .seed),
            QuickAddItem(name: "Fertilizer", image: "ladybug.slash.circle.fill", value: .fertilizer),
            QuickAddItem(name: "medicine", image: "pill", value: .medicine),
            QuickAddItem(name: "Fuel", image: "fuelpump", value: .seed),
            QuickAddItem(name: "Electricity", image: "leaf", value: .seed),
            QuickAddItem(name: "Workmanship", image: "figure", value: .seed),
            QuickAddItem(name: "Shipping", image: "truck.box", value: .seed),
            QuickAddItem(name: "Credit", image: "dollarsign", value: .seed),
            QuickAddItem(name: "Insurance", image: "building.columns", value: .seed),
            QuickAddItem(name: "Other", image: "plus", value: .seed)
        ]
    }
}
