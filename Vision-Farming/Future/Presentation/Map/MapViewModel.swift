//
//  MapViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/15/25.
//

import Foundation

final class MapViewModel : ObservableObject {
    
    @Inject private var userRepository : UserRepositoryProtocol
    
    @Published var user : User? = nil
    
   
    func fetch() async {
        do{
            user = try await userRepository.fetch().get()
        }
        catch{
            print(error)
        }
    }
    
    
    
}
