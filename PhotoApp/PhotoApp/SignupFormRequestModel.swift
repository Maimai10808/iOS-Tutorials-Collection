//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by mac on 8/5/25.
//  Copyright © 2025 Sergey Kargopolov. All rights reserved.
//

import Foundation


struct SignupFormRequestModel: Encodable {
        let firstName: String
        let lastName: String
        let email: String
        let password: String
}
