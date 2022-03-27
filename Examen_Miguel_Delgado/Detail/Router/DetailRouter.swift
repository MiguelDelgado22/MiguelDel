//
//  DetailRouter.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 12/03/22.
//

import UIKit

class DetailRouter {
  
  var viewController: UIViewController {
    return createViewController()
  }
  
  var movieId: String?
  private var sourceView: UIViewController?
  
  
  init(movieId: String? = "") {
    self.movieId = movieId
  }
  
  func setSourceView(_ sourceView: UIViewController?) {
    guard let view = sourceView else {fatalError("Error View Login")}
    self.sourceView = view
  }
  
  private func createViewController() -> UIViewController {
    let view = DetailViewController(nibName: "DetailViewController", bundle: Bundle.main)
    view.movieId = movieId
    return view
  }
}
