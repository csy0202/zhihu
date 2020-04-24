//
//  VipBannerModel.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/20.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import HandyJSON

struct VipBannerModel: HandyJSON {
    var navs = [Nav]()
    var banners = [Banner]()
}

struct Nav: HandyJSON {
    var url: String?
    var title: String?
    var sub_icon: String?
    var id: String?
    var show_sub_icon: Bool = false
    var icon: String?
}

struct Banner: HandyJSON {
    var url: String?
    var artwork: String?
}


