//
//  LoginViewModel.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 09/03/22.
//

import Foundation
import RxSwift
import AuthenticationServices

class LoginViewModel: ObservableObject {
  @Published var miVarable: String = ""
  
  private weak var view: LoginViewController?
  private var router = LoginRouter()
  private var interactor = LoginInteractor()
  
  var textError: String = "" {
    didSet {
      view?.checkLabelError(error: textError)
    }
  }
  
  func bind(view: LoginViewController) {
    self.view = view
    self.router.setSourceView(view)
  }
  
  func getLogin(userName: String, password: String) {
    interactor.webServicesLogin() { token, textError in
      
      guard let error = textError else {
        self.authorizeRequestToken(userName: userName, password: password, from: self.view!, requestToken: token)
        return
        
      }
      self.textError = error
      
    }
  }
  
  func makeDetailView() {
    router.navigateToHome()
  }
  
  func authorizeRequestToken(userName: String, password: String, from viewController: UIViewController, requestToken: String) {
    
    let url = URL(string: "https://www.themoviedb.org/authenticate/\(requestToken)?redirect_to=miguelDelgado://")
    
    guard let authURL = url else { return }
    
    let scheme = "auth"
    
    let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme)
    { callbackURL, error in
      guard error == nil, let callbackURL = callbackURL else { return }
      let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
      guard let requestToken = queryItems?.first(where: { $0.name == "request_token" })?.value else { return }
      self.getSession(userName: userName, password: password, token: requestToken)
      
    }
    session.presentationContextProvider = view
    session.start()
    
  }
  
  func getSession (userName: String, password: String,token: String) {
    interactor.startSession(username: userName, password: password, requestToken: token) { value in
      if value {
        DispatchQueue.main.async {
          self.router.navigateToHome()
        }
      } else {
        self.textError = "Verifique el usuario"
      }
    }
  }
  
  
}
