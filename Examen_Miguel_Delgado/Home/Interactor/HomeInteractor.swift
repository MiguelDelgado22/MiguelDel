//
//  HomeInteractor.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 11/03/22.
//

import Foundation
import RxSwift
import CoreData

class HomeInteractor {
  static let shared = HomeInteractor()
  
  init(){}
  
  private var manager = ManagerConnection()
  let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  var arrayFavorite: [Favorite] = []
  
  func getMoviesPopular() -> Observable<MoviesPopular> {
    return manager.managerConnection(endPoint: Constants.EndPoints.urlListPopularMovies, parameters: [:])
  }
  
  func wsLogOut(completion: @escaping (Bool) -> Void) {
    let parameters = ["session_id" : LoginInteractor.shared.session]
    
    manager.managerToken(Constants.EndPoints.logOut, method: "DELETE", parameters: parameters) { data, error in
      guard let _ = data, error == nil else {
        completion(false)
        return
      }
      completion(true)
    }
  }
  
  func getData() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            if let results = try managedObjectContext.fetch(fetchRequest) as? [Favorite] {
              HomeInteractor.shared.arrayFavorite = results
            }
        } catch {
            print("Failed to fetch data request.")
        }

  }
}
