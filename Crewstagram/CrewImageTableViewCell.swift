//
//  CrewImageTableViewCell.swift
//  Crewstagram
//
//  Created by Kerry Washington on 10/7/17.
//  Copyright © 2017 Grunt Software. All rights reserved.
//

import UIKit

class CrewImageTableViewCell: UITableViewCell {
 
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var crewImageView: UIImageView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.favoriteLabel.text = nil
        self.crewImageView.image = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.crewImageView.image = UIImage.init(named: "staticImage")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
