//
//  AmuseViewModel.swift
//  XDYZB
//
//  Created by takamashiro on 2016/10/11.
//  Copyright © 2016年 com.takamashiro. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {

}
extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(URLString: kGetAmuseData, finishedCallback: finishedCallback)
    }
}
