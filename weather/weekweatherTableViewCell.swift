//
//  weekweatherTableViewCell.swift
//  weather
//
//  Created by swift on 2017/5/3.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit

class weekweatherTableViewCell: UITableViewCell {
//拖
    @IBOutlet weak var weekend: UILabel!
    @IBOutlet weak var weatherimage: UIImageView!
    @IBOutlet weak var nightimage: UIImageView!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  

}
