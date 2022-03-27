//
//  PerfilRepository.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 25/03/22.
//

import Foundation
import RxSwift
import CoreData

class PerfilRepository {
  static let shared = PerfilRepository()
  private var manager = ManagerConnection()
  let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var arrayFavorite: [Favorite] = []
  
  func getPerfil() -> Observable<PerfilModel> {
    return manager.managerConnection(endPoint: Constants.EndPoints.perfil, urlWithSession: true, parameters: [:])
  }
  
  
  func getData(complete: @escaping ([Favorite]) -> Void) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            if let results = try managedObjectContext.fetch(fetchRequest) as? [Favorite] {
              arrayFavorite = results
              complete(results)
            }
        } catch {
            print("Failed to fetch data request.")
        }

  }
}
