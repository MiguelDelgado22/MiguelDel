//
//  LoginRouter.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 09/03/22.
//

import Foundation
import UIKit


class LoginRouter {
  
  var viewController: UIViewController {
    return createViewController()
  }
  
  private var sourceView: UIViewController?

  private func createViewController() -> UIViewController {
    let view = LoginViewController(nibName: "LoginViewController", bundle: Bundle.main)
    return view
  }
  
  func setSourceView(_ sourceView: UIViewController?) {
    guard let view = sourceView else {fatalError("Error View Login")}
    self.sourceView = view
  }
  
  
  func navigateToHome() {
    let homeView = HomeRouter().viewController
    sourceView?.navigationController?.pushViewController(homeView, animated: true)
  }
  
}
