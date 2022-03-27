//
//  DetailViewController.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 12/03/22.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
  
  //MARK: IBOutlet and IBAction
  @IBOutlet private weak var viewBackground: UIView!
  @IBOutlet private weak var lbTitle: UILabel!
  @IBOutlet private weak var imgMovie: UIImageView!
  @IBOutlet private weak var lbOverview: UILabel!
  @IBOutlet private weak var lbPopularity: UILabel!
  @IBOutlet private weak var lbStatus: UILabel!
  @IBOutlet private weak var lbTagLine: UILabel!
  @IBOutlet private weak var collectionProduction: UICollectionView!
  @IBOutlet weak var btoFavorite: UIButton!
  
  @IBAction func btoFavorite(_ sender: Any) {
    if tapFavorite {
      movie?.isFavorite = false
      tapFavorite = false
      viewModel.deleteData(isFavorite: tapFavorite)
      btoFavorite.setImage(UIImage(systemName: "heart"), for: .normal)
    } else {
      movie?.isFavorite = true
      tapFavorite = true
      viewModel.saveData(isFavorite: tapFavorite)
      btoFavorite.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
    }
  }
  
  
  private var viewModel = DetailViewModel()
  private var disposeBag = DisposeBag()
  var movieId: String?
  var tapFavorite: Bool = false
  var arrayFavorite: [Favorite] = []
  var movie: Favorite?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.bind(view: self)
    configureCollectionView()
    getDataAndShowDetailMove()
    setupObserver()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setValueDB()
  }
  
  
  private func configureCollectionView() {
    collectionProduction.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionViewCell")
    collectionProduction.delegate = self
    viewBackground.backgroundColor = UIColor(named: .colorBackgroundCell)
    viewBackground.layer.cornerRadius = 20
    lbTitle.textColor = UIColor(named: .colorTitleCell)
    lbOverview.textColor = UIColor(named: .colorTitleCell)
    lbPopularity.textColor = UIColor(named: .colorTitleCell)
    lbStatus.textColor = UIColor.white
    lbTagLine.textColor = UIColor.white
  }
  
  private func setValueDB() {
    arrayFavorite = HomeInteractor.shared.arrayFavorite
    movie = arrayFavorite.first(where: { $0.title == lbTitle.text })
    btoFavorite.setImage( movie?.isFavorite ?? false ? UIImage(systemName: "suit.heart.fill") : UIImage(systemName: "heart"), for: .normal)
    guard let isFav = movie?.isFavorite else { return }
    tapFavorite = isFav
  }
  
  
  private func getDataAndShowDetailMove() {
    guard let id = movieId else { return }
    viewModel.getDetailMovieData(movieId: id)
  }
  
  func setupObserver() {
    viewModel.detailObserver
      .asObservable()
      .map { $0.title }
      .distinctUntilChanged()
      .bind(to: self.lbTitle.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.detailObserver
      .asObservable()
      .map { "Description: \($0.overview)" }
      .distinctUntilChanged()
      .bind(to: self.lbOverview.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.detailObserver
      .asObservable()
      .map { "Popularity: \($0.popularity)" }
      .distinctUntilChanged()
      .bind(to: self.lbPopularity.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.detailObserver
      .asObservable()
      .map { "Status: \($0.status)" }
      .distinctUntilChanged()
      .bind(to: self.lbStatus.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.detailObserver
      .asObservable()
      .map { "Tag: \($0.tagline)" }
      .distinctUntilChanged()
      .bind(to: self.lbTagLine.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.imagePath
      .subscribe( onNext: { [weak self] in
        if !$0.isEmpty {
          self?.imgMovie.imageFromServerURL(urlString: "\(Constants.URL.urlImages+$0)", placeHolderImage: UIImage(named: "placeHolder")!)
        }
      })
      .disposed(by: disposeBag)
    
    viewModel.arrayImageProductionObservable
      .bind(to: collectionProduction
              .rx
              .items(cellIdentifier: "DetailCollectionViewCell",
                     cellType: DetailCollectionViewCell.self)) { row, image, cell in
        
        guard let image = image.logoPath else { return }
        cell.imgMovie.imageFromServerURL(urlString: "\(Constants.URL.urlImages+image)", placeHolderImage: UIImage(named: "placeHolder")!)
      }
                     .disposed(by: disposeBag)
  }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    let cellWidth = (width - 10) / 2
    return CGSize(width: cellWidth, height: cellWidth)
  }
}
