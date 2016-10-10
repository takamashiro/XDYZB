//
//  CollectionGameCell.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/1.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: 定义模型属性
    var gameModel : GameBaseModel? {
        didSet {
            titleLabel.text = gameModel?.tag_name
            if let iconURL = URL(string: gameModel?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL, placeholder:  UIImage(named: "home_more_btn"))
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
}
