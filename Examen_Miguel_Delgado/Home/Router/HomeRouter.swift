//
//  HomeRouter.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 11/03/22.
//

import UIKit

class HomeRouter {
  var viewController: UIViewController {
    return createViewController()
  }
  
  private var sourceView: UIViewController?
  
  func setSourceView(_ sourceView: UIViewController?) {
    guard let view = sourceView else {fatalError("Error View Login")}
    self.sourceView = view
  }
  
  private func createViewController() -> UIViewController {
    let view = HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
        return view
  }
  
  func gotoDetailViewController(id:Int) {
    let detailView = DetailRouter(movieId: "\(id)").viewController
    sourceView?.navigationController?.pushViewController(detailView, animated: true)
  }
  
  func gotoPerfilViewController() {
    let perfil = PerfilRouter().viewController
    sourceView?.navigationController?.pushViewController(perfil, animated: true)
  }
  
  func gotoRoot() {
    sourceView?.navigationController?.popToRootViewController(animated: true)
  }
}
