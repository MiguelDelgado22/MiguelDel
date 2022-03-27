//
//  HomeViewModel.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 11/03/22.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel {
  private(set) weak var view: HomeViewController?
  private var router = HomeRouter()
  private var interactor = HomeInteractor()
  private var disposeBag = DisposeBag()
  private var movies: BehaviorRelay<[MoviePopular]> = BehaviorRelay(value: [])
  
  var movieObserver : Observable<[MoviePopular]> {
    return movies.asObservable()
  }
  
  func bind(view: HomeViewController) {
    self.view = view
    self.router.setSourceView(view)
    interactor.getData()
  }
  
  func getMovieData() {
   return interactor.getMoviesPopular()
      .subscribe(on: MainScheduler.instance)
      .observe(on: MainScheduler.instance)
      .subscribe { movies in
        self.movies.accept(movies.movies)
      } onError: { error in
        print(error.localizedDescription)
      } onCompleted: {}.disposed(by: disposeBag)
  }
  
  func gotoDetail(idMovie: Int) {
    router.gotoDetailViewController(id: idMovie)
  }
  
  func gotoPerfil() {
    router.gotoPerfilViewController()
  }
  
  func logOut() {
    
    interactor.wsLogOut { value in
      if value {
        self.router.gotoRoot()
      }
    }
  }
}
