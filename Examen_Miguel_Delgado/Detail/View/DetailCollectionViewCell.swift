//
//  DetailCollectionViewCell.swift
//  Examen_Miguel_Delgado
//
//  Created by Miguel Angel Delgado Alcantara on 16/03/22.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imgMovie: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
      imgMovie.layer.cornerRadius = 20
      imgMovie.contentMode = .scaleAspectFit    }

}
