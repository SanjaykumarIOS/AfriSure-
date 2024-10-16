//
//  LoginModel.swift
//  DynamicFileUpload
//
//  Created by SANJAY  on 28/12/23.
//

import SwiftUI

class LoginResponse: Decodable {
    let rcode: Int
    let rObj: LoginValues?
    let rmsg: [LoginMessage]
    
    class LoginValues: Decodable {
        let barcodeImageUrl: URL?
        let token: String
        let isGoogleAuthenticatorRegistered: Bool
        let refreshToken: String
    }
}

class LoginMessage: Decodable {
    let errorText: String
    let errorCode: String
    let fieldName: String?
    let fieldValue: String?
}
