//
//  DashboardViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/13/25.
//

import Foundation

final class DashboardViewModel : BaseViewModel{
    
    @Published public var user : User?
    @Published public var error : NetworkErrorCallback?
    
    
    init(rootViewModel : RootViewModel) {
        super.init()
        rootViewModel.$user
            .assign(to: &$user)
        rootViewModel.$error
            .assign(to: &$error)
    }
    
}
