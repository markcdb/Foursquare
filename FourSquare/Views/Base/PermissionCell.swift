//
//  PermissionCell.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 02/02/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

protocol PermissionCellDelegate: class {
    func didTapPermissionButton(_ sender: UIButton)
}

class PermissionCell: UITableViewCell {

    @IBOutlet weak var permissionLabel: UILabel!
    @IBOutlet weak var permissionButton: UIButton!
    
    weak var delegate: PermissionCellDelegate!
}

//MARK: - Overrides
extension PermissionCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

//MARK: - Actions
extension PermissionCell {
    
    @IBAction func didTapPermission(_ sender: UIButton) {
        
        delegate?.didTapPermissionButton(sender)
    }
}
