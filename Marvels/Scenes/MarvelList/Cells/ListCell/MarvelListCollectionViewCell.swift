//
//  MarvelListCollectionViewCell.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import UIKit
import Kingfisher


protocol MarvelListCollectionViewCellDataSource {
    
    func imageForCell(_ cell: MarvelListCollectionViewCell) -> URL
    func titleForCell(_ cell: MarvelListCollectionViewCell) -> String
    func seriesForCell(_ cell: MarvelListCollectionViewCell) -> String
    
}

class MarvelListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var seriesLbl: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    var dataSource: MarvelListCollectionViewCellDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImg.contentMode = .scaleAspectFill
        avatarImg.layer.cornerRadius = avatarImg.frame.size.height / 2

        
    }
    
    func reloadData() {
        avatarImg.kf.setImage(with: dataSource?.imageForCell(self), placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        avatarImg.clipsToBounds = true
        nameLbl.text = dataSource?.titleForCell(self)
        seriesLbl.text = dataSource?.seriesForCell(self)
        bigView.backgroundColor = UIColor.navigationBackground()
        nameLbl.textColor = .white
        seriesLbl.textColor = .white
    }


}
