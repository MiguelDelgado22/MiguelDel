//
//  MovieCell.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 11/03/22.
//

import UIKit

class MovieCell: UICollectionViewCell {

  //MARK: IBOutlet
  @IBOutlet weak var viewBackground: UIView!
  @IBOutlet weak var imgMovie: UIImageView!
  @IBOutlet weak var lbTitle: UILabel!
  @IBOutlet weak var lbDateMovie: UILabel!
  @IBOutlet weak var lbCalificationMovie: UILabel!
  @IBOutlet weak var lbDescriptionMovie: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
    setUpView()
    
    }
  
  private func setUpView() {
    viewBackground.backgroundColor = UIColor(named: .colorBackgroundCell)
    viewBackground.layer.cornerRadius = 20
    imgMovie.layer.cornerRadius = 20
    imgMovie.contentMode = .scaleAspectFill
    lbTitle.textColor = UIColor(named: .colorTitleCell)
    lbDateMovie.textColor = UIColor(named: .colorTitleCell)
    lbCalificationMovie.textColor = UIColor(named: .colorTitleCell)
    lbDescriptionMovie.textColor = UIColor.white
  }

}
