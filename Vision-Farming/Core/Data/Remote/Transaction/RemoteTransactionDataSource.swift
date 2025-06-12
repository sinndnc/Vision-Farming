//
//  TransactionDataSource.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/9/25.
//

import Foundation
import Combine


protocol RemoteTransactionDataSource {
    
    func getTransactions(for owner_id: String) -> AnyPublisher<[Transaction], Error>
}
