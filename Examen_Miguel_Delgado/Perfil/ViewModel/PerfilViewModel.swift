//
//  PerfilViewModel.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 25/03/22.
//

import Foundation
import RxSwift
import RxRelay
import CoreData

class PerfilViewModel {
  
  private(set) weak var view: PerfilViewController?
  private var router = HomeRouter()
  private var repository = PerfilRepository()
  
  private var disposeBag = DisposeBag()
  
  var myImageURL: BehaviorRelay<String> = BehaviorRelay(value: "")
  var userName: BehaviorRelay<String> = BehaviorRelay(value: "")
  
  var imagePath: Observable<String> {
    return myImageURL.asObservable()
  }
  
  var userNameObservable: Observable<String> {
    return userName.asObservable()
  }
  
  var listArray: [FavoriteModel] = []
  
  private var movies: BehaviorRelay<[Favorite]> = BehaviorRelay(value: [])
  
  var movieObserver : Observable<[Favorite]> {
    return movies.asObservable()
  }
  
  func bind(view: PerfilViewController) {
    self.view = view
    self.router.setSourceView(view)
  }
  
  func getAccount() {
    return repository.getPerfil()
      .subscribe(on: MainScheduler.instance)
      .observe(on: MainScheduler.instance)
      .subscribe { perfil in
        self.myImageURL.accept(perfil.avatar.tmdb.avatar_path)
        self.userName.accept(perfil.username)
      } onError: { error in
        print(error.localizedDescription)
      } onCompleted: {}.disposed(by: disposeBag)
  }
  
  func getDataOfBD() {
    repository.getData { object in
      self.movies.accept(object)
    }
  }
}
