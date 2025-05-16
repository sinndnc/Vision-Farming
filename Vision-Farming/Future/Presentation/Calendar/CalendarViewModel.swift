//
//  CalendarViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/17/25.
//

import Foundation


final class CalendarViewModel : ObservableObject{
    
    @Published var selectedHeaderDay : Int = 0
    @Published var classifiedReminders : [Int :[Reminder]] = [:]
    
}
