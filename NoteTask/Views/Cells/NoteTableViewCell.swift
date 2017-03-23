//
//  NoteTableViewCell.swift
//  NoteTask
//
//  Created by Duc Nguyen on 3/21/17.
//  Copyright © 2017 Duc Nguyen. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var lbCreatAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
