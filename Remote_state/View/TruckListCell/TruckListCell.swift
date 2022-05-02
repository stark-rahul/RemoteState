//
//  TruckListCell.swift
//  Remote_state
//
//  Created by Apple on 29/04/22.
//

import UIKit

class TruckListCell: UITableViewCell {

    @IBOutlet weak var truckName: UILabel!
    @IBOutlet weak var idelTime: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var truckSpeed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
