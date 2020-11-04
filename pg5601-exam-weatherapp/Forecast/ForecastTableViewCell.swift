//
//  ForecastTableViewCell.swift
//  pg5601-exam-weatherapp
//
//  Created by Krister Emanuelsen on 26/10/2020.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet var title : UILabel!;
    @IBOutlet var descriptor : UILabel!;
    @IBOutlet var possibleValue : UILabel!;
    @IBOutlet var unitValue : UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
