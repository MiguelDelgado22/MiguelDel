//
//  LoginViewController.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 09/03/22.
//

import UIKit
import RxSwift
import AuthenticationServices

class LoginViewController: UIViewController {
  
  //MARK: IBOutlet and IBAction
  @IBOutlet private weak var backgroundImg: UIImageView!
  @IBOutlet private weak var userTxd: UITextField!
  @IBOutlet private weak var passwordTxd: UITextField!
  @IBOutlet private weak var loginInButton: UIButton!
  @IBOutlet private weak var errorLbl: UILabel!
  
  @IBAction func loginInButtonAction(_ sender: Any) {
    viewModel.getLogin(userName: userTxd.text ?? "", password: passwordTxd.text ?? "")
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    }
  }
  
  
  //MARK: Properties
  private var viewModel = LoginViewModel()
  private var disposeBag = DisposeBag()
  

  //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel.bind(view: self)
      
      configView()
    }
  
  //MARK: Configuration Functions
  
  func checkLabelError(error: String) {
    DispatchQueue.main.async {
      self.errorLbl.isHidden = false
      self.errorLbl.text = error
    }
   }
  
  func configView() {
    let imageLogin: UIImage = UIImage(named: Constants.ImageName.imageLogin)!
    backgroundImg.image = imageLogin
    backgroundImg.contentMode = .scaleAspectFill
    userTxd.placeholder = Constants.ConstantsString.placeHolderUserName
    passwordTxd.placeholder = Constants.ConstantsString.placeHolderPassword
    loginInButton.backgroundColor = .gray
    loginInButton.setTitle("Log In", for: .normal)
    loginInButton.setTitleColor(.white, for: .normal  )
    errorLbl.textColor = .red
    errorLbl.isHidden = true
  }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return view.window!
  }
}
