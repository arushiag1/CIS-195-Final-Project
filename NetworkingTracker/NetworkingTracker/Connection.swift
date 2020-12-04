//
//  Connection.swift
//  NetworkingTracker
//
//  Created by Arushi Aggarwal on 12/3/20.
//

import UIKit

class Connection {
    
    var firstName: String
    var lastName: String
    var company: String?
    var role: String?
    var email: String?
    var phoneNumber: String?
    
    init?(firstName: String, lastName: String, company: String?, role: String?, email: String?, phoneNumber: String?) {
        
        guard !firstName.isEmpty && !lastName.isEmpty  else {
            return nil;
        }

        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.role = role
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
