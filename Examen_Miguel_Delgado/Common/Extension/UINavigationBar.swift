//
//  UINavigationBar.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 24/03/22.
//

import Foundation
import UIKit

extension UINavigationBar {
    func customNavigationBar() {
        // color for button images, indicators and etc.
      self.tintColor = UIColor.white

        // color for background of navigation bar
        // but if you use larget titles, then in viewDidLoad must write
        // navigationController?.view.backgroundColor = // your color
        self.barTintColor = .white
        self.isTranslucent = true

        // for larget titles
        self.prefersLargeTitles = false

        // color for large title label
        self.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // color for standard title label
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
