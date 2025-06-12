//
//  Date+Extension.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/17/25.
//

import Foundation

extension Date {
    
    var minute : Int { Calendar.current.component(.minute, from: self) }
    
    var hour : Int { Calendar.current.component(.hour, from: self) }
    
    var day : Int { Calendar.current.component(.day, from: self) }
    
    var month: Int { Calendar.current.component(.month, from: self) }
    
}
