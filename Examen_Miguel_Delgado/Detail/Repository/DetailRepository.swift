//
//  DetailRepository.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 12/03/22.
//

import Foundation
import RxSwift
import CoreData

class DetailRepository {
  
  private var manager = ManagerConnection()
  let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  func getMoviesDetail(idMovie: String) -> Observable<MovieDetail> {
    return manager.managerConnection(endPoint: Constants.EndPoints.urlDetailMovie+idMovie, parameters: [:])
  }
  
  func saveData(model: FavoriteModel) {
    
    let entity = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: self.managedObjectContext) as! Favorite
    entity.title = model.title;
    entity.favorite = model.favorite;
    entity.isFavorite = model.isFavorite;
    entity.image = model.image;
    entity.date = model.date;
    entity.descriptionaImage = model.descriptionaImage;
   
    var error: Error?
    
    do {
      try managedObjectContext.save()
    } catch let error1 {
      error = error1
    }
    if error != nil {
      print("Dont save")
    } else {
     print("Save")
    }
  }
  
  func deleteData(object: Favorite) {
    managedObjectContext.delete(object)

    do {
      try managedObjectContext.save()
    } catch _ {}
  }
}
