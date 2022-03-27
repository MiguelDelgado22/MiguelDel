//
//  PerfilRouter.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 25/03/22.
//

import UIKit

class PerfilRouter {
  
  var viewController: UIViewController {
    return createViewController()
  }
  
  private var sourceView: UIViewController?
  
  func setSourceView(_ sourceView: UIViewController?) {
    guard let view = sourceView else {fatalError("Error View Login")}
    self.sourceView = view
  }
  
  private func createViewController() -> UIViewController {
    let view = PerfilViewController(nibName: "PerfilViewController", bundle: Bundle.main)
        return view
  }
}
