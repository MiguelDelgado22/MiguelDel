//
//  LoginModel.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 10/03/22.
//

import Foundation

struct TokenModel: Codable {
  
  let success: Bool
  let experies: String?
  let token: String?
  let statusMessage: String?
  
  enum CodingKeys: String, CodingKey {
    case success
    case experies = "expires_at"
    case token = "request_token"
    case statusMessage = "status_message"
  }
}

struct SessionModel: Codable {
  let success: Bool
  let session_id: String
}


