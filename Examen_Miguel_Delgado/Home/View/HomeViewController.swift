//
//  HomeViewController.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 11/03/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
  
  @IBOutlet private weak var segmentControl: UISegmentedControl!
  @IBOutlet private weak var collectionView: UICollectionView!
  private var viewModel = HomeViewModel()
  private var disposeBag = DisposeBag()
  private var actionSheet = ActionSheetController()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    viewModel.bind(view: self)
    viewModel.getMovieData()
    setupObserver()
    setUpView()
  }
  
  private func configureCollectionView() {
    self.navigationItem.setHidesBackButton(true, animated: true)
    collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    collectionView.delegate = self
  }
  
  func setupObserver() {
    viewModel.movieObserver
      .bind(to: collectionView
              .rx
              .items(cellIdentifier: "MovieCell",
                     cellType: MovieCell.self)) { row, movie, cell in
        cell.lbTitle.text = movie.title
        cell.lbDateMovie.text = movie.releaseDate
        cell.lbCalificationMovie.attributedText = self.getAttributedTextForCalification(completText: " \(movie.voteAverage)")
        cell.lbDescriptionMovie.text = movie.description
        cell.imgMovie.imageFromServerURL(urlString: "\(Constants.URL.urlImages+movie.posterPath)", placeHolderImage: UIImage(named: "placeHolder")!)
      }.disposed(by: disposeBag)
    
    collectionView
      .rx
      .modelSelected(MoviePopular.self)
      .subscribe { item in
        self.viewModel.gotoDetail(idMovie: item.id)
      } .disposed(by: disposeBag)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configNavigationBar()
}
  
  private func configNavigationBar() {
    self.title = "TV Shows"
    let buttonIcon = UIImage(systemName: "line.3.horizontal")
    let play = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(playTapped))
    play.image = buttonIcon
    navigationItem.rightBarButtonItem = play
  }
  
  @objc func playTapped() {
    
    let data = DataActionSheet(title:
                                Constants.ConstantsString.titleActionSheet,
                               nameFirstButtom: Constants.ConstantsString.optionOne, actionFirst: { action1 in
      self.viewModel.gotoPerfil()
    }, nameSecondButtom: Constants.ConstantsString.logOut) { action2 in
      self.viewModel.logOut()
    }
    actionSheet.showActionSheet(data: data, viewController: self)
  }
  
  private func setUpView() {
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    segmentControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
    segmentControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
  }
  
  private func getAttributedTextForCalification(completText: String) -> NSMutableAttributedString {
    let imageAttachment = NSTextAttachment()
    imageAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(UIColor(named: .colorTitleCell))
    let fullString = NSMutableAttributedString(attachment: imageAttachment)
    fullString.append(NSAttributedString(string: completText))
    return fullString
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.bounds.width
    let cellWidth = (width - 10) / 2
    return CGSize(width: cellWidth, height: cellWidth / 0.6)
  }
}
