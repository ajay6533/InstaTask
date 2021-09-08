//
//  textTableViewCell.swift
//  Challenge2
//
//  Created by ajaykumar on 29/08/21.
//

import UIKit

class textTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLable: UILabel!
    @IBOutlet weak var containerView: UIView!
    let colorArray = [UIColor.green, UIColor.red, UIColor.purple, UIColor.orange, UIColor.blue]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let randomInt = Int(arc4random()) % colorArray.count
//        self.containerView.backgroundColor = colorArray[randomInt]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
