//
//  ListActorsTableViewCell.swift
//  TMDB
//
//  Created by sara.galal on 9/29/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ListActorsTableViewCell: UITableViewCell {
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 10
        cellView.layer.masksToBounds = false
        cellView.layer.shadowColor = UIColor.darkGray.cgColor
        cellView.layer.shadowOpacity = 0.1
        cellView.layer.shadowOffset = CGSize.zero
        cellView.layer.shadowRadius = 10
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = self.profileImage.frame.height/2
        profileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(person: Person){
        if let name = person.name{
        nameLabel.text = name
        }else {
            nameLabel.text = "no name available"
        }
        if let popularity = person.popularity {
        popLabel.text = "\(popularity)"
        }else {
            popLabel.text = "\(0)"
        }
        if let urlStr = person.profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/original"+urlStr)
            let placeholderImage = UIImage(named: "noimage.png")
            if let imgUrl = url ,let placeholder = placeholderImage {
            profileImage.af_setImage(withURL: imgUrl, placeholderImage: placeholder)
            }
        } else {
            profileImage.image = UIImage(named: "noimage.png")
        }
    }
}
