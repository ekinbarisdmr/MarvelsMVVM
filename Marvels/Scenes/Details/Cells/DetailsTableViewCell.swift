//
//  DetailsTableViewCell.swift
//  Marvels
//
//  Created by Ekin Barış Demir on 16.08.2021.
//

import UIKit
import Kingfisher


protocol DetailsTableViewCellDataSource {
    
    func imageForCell(_ cell: DetailsTableViewCell) -> URL
    func seriesForCell(_ cell: DetailsTableViewCell) -> String
    func comicForCell(_ cell: DetailsTableViewCell) -> String
    func eventsForCell(_ cell: DetailsTableViewCell) -> String
    func nameForCell(_ cell: DetailsTableViewCell) -> String
    func storiesForCell(_ cell: DetailsTableViewCell) -> String
    
}

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    var dataSource: DetailsTableViewCellDataSource?
    var review: () -> () = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImg.contentMode = .scaleAspectFill
        avatarImg.layer.cornerRadius = avatarImg.frame.size.height / 2
    }
    
    func reloadData() {
        nameLabel.textColor = .black
        nameLabel.text = dataSource?.nameForCell(self)
        comicsLabel.text = dataSource?.comicForCell(self)
        eventsLabel.text = dataSource?.eventsForCell(self)
        seriesLabel.text = dataSource?.seriesForCell(self)
        storiesLabel.text = dataSource?.storiesForCell(self)
        avatarImg.kf.setImage(with: dataSource?.imageForCell(self), placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
    }
    
    @IBAction func reviewButton(_ sender: Any) {
        review()
    }
    
}
