//
//  adviceCollectionViewCell.swift
//  weather
//
//  Created by swift on 2017/5/4.
//  Copyright © 2017年 swift. All rights reserved.
//

import UIKit

class adviceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var advice: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
