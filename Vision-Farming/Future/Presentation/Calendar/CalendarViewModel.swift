//
//  CalendarViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/17/25.
//

import Foundation


final class CalendarViewModel : BaseViewModel{
    
    @Published var selectedHeaderDay : Int = 0
    @Published var classifiedReminders : [Int :[Reminder]] = [:]
    
    @Published public var error : NetworkErrorCallback?
    
    init(rootViewModel : RootViewModel) {
        super.init()
        rootViewModel.$error
            .assign(to: &$error)
    }
    
}
