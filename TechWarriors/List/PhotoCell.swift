//
//  PhotoCell.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 07/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photo : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photo.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    func setup(url : String?) {
        if let url = url {
            photo.sd_setImage(with: URL(string: url), completed: nil)
        }
    }
}
