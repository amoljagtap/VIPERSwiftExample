//
//  AutoManufacturerTableViewCell.swift
//  AutoCatalog
//
//  Created by Jagtap, Amol on 1/8/17.
//  Copyright © 2017 Amol Jagtap. All rights reserved.
//

import UIKit

class AutoManufacturerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    static let reusableIdentifier = String(describing:AutoManufacturerTableViewCell.self)
    
    var title:String?  {
        didSet{
            if let title = title {
                nameLabel.text = title
                layoutIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
}
