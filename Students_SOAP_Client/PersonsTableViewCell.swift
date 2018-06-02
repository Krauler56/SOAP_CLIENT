//
//  PersonsTableViewCell.swift
//  Students_SOAP_Client
//
//  Created by Valentin Nacharov on 02.06.2018.
//  Copyright © 2018 Valentin Nacharov. All rights reserved.
//

import UIKit

class PersonsTableViewCell: UITableViewCell {

    @IBOutlet var firstNameLabel: UILabel!
    
    @IBOutlet var lastNameLabel: UILabel!
    
    @IBOutlet var middleNameLable: UILabel!
    
    @IBOutlet var groupIdLabel: UILabel!
    @IBOutlet var birthDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
