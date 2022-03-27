//
//  LoginInteractor.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 10/03/22.
//

import Foundation
import AuthenticationServices
import RxSwift

class LoginInteractor {
  
  static let shared = LoginInteractor()
  
  
  private var manager = ManagerConnection()
  var token: String = ""
  var session: String = ""
  private var parameters: [String:String] = [:]
  private var disposeBag = DisposeBag()
  private var authSession: ASWebAuthenticationSession?
  
  func webServicesLogin(complete: @escaping (String, String?) -> ()) {
    manager.managerToken(Constants.EndPoints.urlToken, method: "GET", parameters: [:]) { data, error in
      guard let data = data, error == nil else {
        complete(error.debugDescription, error)
        return
      }
      let responseObject = (try? JSONDecoder().decode(TokenModel.self, from: data))
      self.token = responseObject?.token ?? ""
      complete(self.token, nil)
    }
  }
  
  func startSession(username: String, password: String, requestToken: String, completion: @escaping (Bool) -> Void ) {
        self.parameters = [
          "username": username,
          "password": password,
          "request_token": requestToken
        ]
    
        manager.managerToken(Constants.EndPoints.session, method: "POST", parameters: self.parameters) { data, error in
          guard let data = data, error == nil else {
            completion(false)
            return
          }
          do {
          let responseObject = (try JSONDecoder().decode(SessionModel.self, from: data))
            LoginInteractor.shared.session = responseObject.session_id
          completion(true)
          } catch let error {
            print(error)
            completion(false)
          }
        }
  }
}



