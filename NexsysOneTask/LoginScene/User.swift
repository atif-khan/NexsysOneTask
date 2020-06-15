//
//  User.swift
//  NexsysOneTask
//
//  Created by Atif Khan on 15/06/2020.
//  Copyright © 2020 Atif Khan. All rights reserved.
//

import Foundation

struct User: Codable {
    let userName: String
    let password: String
    let name: String
    let email: String
    let age: Int
    let department: String
}
