//
//  PerfilViewController.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 25/03/22.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class PerfilViewController: UIViewController {
  
  @IBOutlet weak var titleView: UILabel!
  
  @IBOutlet weak var imgAvatar: UIImageView!
  
  @IBOutlet weak var userName: UILabel!
  
  @IBOutlet weak var titleFavorite: UILabel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  private var viewModel = PerfilViewModel()
  private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
      viewModel.getAccount()
      setupObserver()
      setupNavigation()
      collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
      collectionView.delegate = self
        
    }
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel.getDataOfBD()
  }
  
  func setupNavigation() {
    self.title = "Profile"
    self.navigationItem.backBarButtonItem?.title = ""
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: .colorTitleCell)]
    imgAvatar.setRounded()
  }
  
  func setupObserver() {
    
    viewModel.userNameObservable
      .asObservable()
      .map { "@\($0)" }
      .distinctUntilChanged()
      .bind(to: self.userName.rx.text)
      .disposed(by: disposeBag)
    
    
    
    viewModel.imagePath
      .subscribe( onNext: { [weak self] in
        if !$0.isEmpty {
          self?.imgAvatar.imageFromServerURL(urlString: "\(Constants.URL.urlImages+$0)", placeHolderImage: UIImage(named: "placeHolder")!)
        }
      })
      .disposed(by: disposeBag)
    
    viewModel.movieObserver
      .bind(to: collectionView
              .rx
              .items(cellIdentifier: "MovieCell",
                     cellType: MovieCell.self)) { row, movie, cell in
        cell.lbTitle.text = movie.title
        cell.lbDateMovie.text = "\(movie.favorite)"
        cell.lbDescriptionMovie.text = movie.descriptionaImage
        cell.lbCalificationMovie.isHidden = true
        cell.imgMovie.imageFromServerURL(urlString: "\(Constants.URL.urlImages+movie.image!)", placeHolderImage: UIImage(named: "placeHolder")!)
        
      }.disposed(by: disposeBag)
  }

}

extension UIImageView {

    func setRounded() {
      self.layer.cornerRadius = (self.frame.size.width / 2) 
        self.layer.masksToBounds = true
    }
}

extension PerfilViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    let cellWidth = (width - 10) / 2
    return CGSize(width: cellWidth, height: 295 )
  }
}
