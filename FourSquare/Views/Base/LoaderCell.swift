//
//  LoaderCell.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 02/02/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class LoaderCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
}

//MARK: - Overrides
extension LoaderCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
