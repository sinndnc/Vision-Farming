//
//  FinancialTransaction.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/9/25.
//

import Foundation
import FirebaseFirestore

struct Transaction: FirestoreEntity {
    @DocumentID var id: String?
    var owner_id : String
    var type: TransactionType
    var amount: Double
    var date: Date
    var description: String?
    var season : Season
    
    var transaction_category: TransactionCategory
    
    var seasonId: String?
    var cropId: String?
}
