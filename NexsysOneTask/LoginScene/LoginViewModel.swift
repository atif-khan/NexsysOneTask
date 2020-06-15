//
//  LoginViewModel.swift
//  NexsysOneTask
//
//  Created by Atif Khan on 15/06/2020.
//  Copyright © 2020 Atif Khan. All rights reserved.
//

import Foundation

struct LoginViewModel {
    
    //Login service response
    struct Response: Codable {
        let status: String
        let message: String
        let user: User

        enum CodingKeys: String, CodingKey {
            case status, message
            case user = "user_profile"
        }
    }

}


