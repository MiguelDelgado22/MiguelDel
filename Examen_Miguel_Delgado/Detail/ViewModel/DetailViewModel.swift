//
//  DetailViewModel.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 12/03/22.
//

import Foundation
import RxSwift
import RxRelay

class DetailViewModel {
  
  private(set) weak var view: DetailViewController?
  private var router = DetailRouter()
  private var repository = DetailRepository()
  private var disposeBag = DisposeBag()
  private var detailMovie: BehaviorRelay<MovieDetail> = BehaviorRelay(value: MovieDetail(title: "", imageMovie: "", overview: "", popularity: 0.0, status: "", tagline: "", prductionCompanies: []))
  
  var detailObserver: Observable<MovieDetail> {
    return (detailMovie.asObservable())
  }
  var myImageURL: BehaviorRelay<String> = BehaviorRelay(value: "")
  
  var imagePath: Observable<String> {
    return myImageURL.asObservable()
  }
  
  func bind(view: DetailViewController) {
    self.view = view
  }
  var arrayImageProduction: BehaviorRelay<[Production]> = BehaviorRelay(value: [])
  
  var arrayImageProductionObservable: Observable<[Production]> {
    return arrayImageProduction.asObservable()
  }
  var data: MovieDetail?
  
  func getDetailMovieData(movieId: String) {
    return repository.getMoviesDetail(idMovie: movieId)
      .subscribe(on: MainScheduler.instance)
      .observe(on: MainScheduler.instance)
      .subscribe { movie in
        self.myImageURL.accept(movie.imageMovie)
        self.detailMovie.accept(movie)
        guard let images = movie.prductionCompanies else { return }
        self.arrayImageProduction.accept(images)
        self.data = movie
      } onError: { error in
        print(error.localizedDescription)
      } onCompleted: {}
      .disposed(by: disposeBag)
  }
  
  func saveData(isFavorite: Bool) {
    repository.saveData(model: getModelForDB(isFavorite: isFavorite))
  }
  
  func deleteData(isFavorite: Bool) {
    let arrayData = HomeInteractor.shared.arrayFavorite
    let currentModel = getModelForDB(isFavorite: isFavorite)
    let object = arrayData.first(where: { $0.title ==  currentModel.title })
    guard let deleteObject = object else { return }
    repository.deleteData(object: deleteObject)
  }
  
  private func getModelForDB(isFavorite: Bool) -> FavoriteModel {
    guard let data = data else { return FavoriteModel(isFavorite: false, title: "", image: "", date: "", descriptionaImage: "", favorite: 0.0) }
    return FavoriteModel(isFavorite: isFavorite, title: data.title, image: data.imageMovie, date: data.tagline, descriptionaImage: data.overview, favorite: data.popularity)
  }
  
}
