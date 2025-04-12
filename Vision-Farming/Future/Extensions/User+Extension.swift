//
//  User+Extension.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/12/25.
//

import Foundation


extension User {
    init(dto: UserDTO) {
        self.uid = dto.uid
        self.role = dto.role
        self.name = dto.name
        self.email = dto.email
        self.surname = dto.surname
        self.farms = []
        self.fields = [:]
        self.sensors = [:]
    }
}
