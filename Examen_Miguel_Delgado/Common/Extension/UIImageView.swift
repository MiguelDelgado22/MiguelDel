//
//  UIImageView.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 12/03/22.
//

import UIKit

extension UIImageView {
  
  func imageFromServerURL(urlString: String, placeHolderImage: UIImage) {
    
    if self.image == nil {
      self.image = placeHolderImage
    }
    
    URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
      
      if error != nil { return }
      
      DispatchQueue.main.async {
        guard let data = data else { return }
        let image = UIImage(data: data)
        self.image = image
      }
    }.resume()
  }
}

extension UINavigationController {
    func transparentNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }

    func setTintColor(_ color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
        self.navigationBar.tintColor = color
    }

    func backgroundColor(_ color: UIColor) {
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.barTintColor = color
        navigationBar.shadowImage = UIImage()
    }
}
