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
    var group : AnchorGroup? {
        didSet {
            
            titleLabel.text = group?.tag_name
            //更多group的group?.icon_url为""
            if group?.icon_url == "" {
                iconImageView.image = UIImage(named: "home_more_btn")
                return
            }
            let iconURL = URL(string: group?.icon_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"), options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
        }
    }

}
