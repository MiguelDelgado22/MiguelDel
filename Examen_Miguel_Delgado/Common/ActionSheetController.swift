//
//  ActionSheetController.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 24/03/22.
//

import Foundation
import UIKit

class ActionSheetController {
  
  func showActionSheet(data: DataActionSheet, viewController: UIViewController) {
    
    let actionSheetController: UIAlertController = UIAlertController(title: data.title, message: nil, preferredStyle: .actionSheet)
    let firstAction: UIAlertAction = UIAlertAction(title: data.nameFirstButtom, style: .default) { action -> Void in
      data.actionFirst(action)
    }
    let secondAction: UIAlertAction = UIAlertAction(title: data.nameSecondButtom, style: .default) { action -> Void in

      data.actionSecond(action)
    }
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
    
    actionSheetController.addAction(firstAction)
    actionSheetController.addAction(secondAction)
    actionSheetController.addAction(cancelAction)
    
  viewController.present(actionSheetController, animated: true)
 }
}

struct DataActionSheet {
  var title: String
  var nameFirstButtom: String
  var actionFirst: (UIAlertAction) -> Void
  var nameSecondButtom: String
  var actionSecond: (UIAlertAction) -> Void
}

