//
//  HotTitleModel.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/10.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import HandyJSON

struct HotTitleModel: HandyJSON {
    var rec_data = [TitleModel]()
    var data = [TitleModel]()
}

struct TitleModel: HandyJSON {
    var fake_url: String = ""
    var page_id: Int = 0
    var name: String = ""
    var identifier: String = ""
}

