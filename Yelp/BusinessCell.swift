//
//  BusinessCell.swift
//  Yelp
//
//  Created by Terra Oldham on 9/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var starsImageView: UIImageView!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            reviewLabel.text = String(format: "%d", business.reviewCount!) + " Reviews"
            addressLabel.text = business.address
            typeLabel.text = business.categories
            distanceLabel.text = business.distance
            photoView.setImageWith(business.imageURL!)
            starsImageView.setImageWith(business.ratingImageURL!)
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoView.layer.cornerRadius = 5
        photoView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
