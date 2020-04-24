//
//  VipHeaderModel.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/17.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import HandyJSON
struct VipHeaderModel: HandyJSON {
    var avatar_url: String = ""
    var sub_webs = [Sub_webs]()
    var url_token: String = ""
    var svip_note: Svip_note?
    var user_type: String = ""
    var id: String = ""
    var type: String = ""
    var name: String = ""
    var gender: Int = 0
    var content: String = ""
    var headline: String = ""
    var url: String = ""
}

struct Module: HandyJSON {
    var contents = [Content]()
    var title: String?
    var target_url: String?
    var id: Int = 0
    var type: Int = 0
    var target_title: String?
}

struct Svip_note: HandyJSON {
    var saving_money: Float = 0.0
}

struct Sub_webs: HandyJSON {
    var buried_point: Int = 0
    var title: String = ""
    var type: String = ""
    var url: String = ""
}

/// 会员推荐模板
struct VipModuleList: HandyJSON {
    var vip_promotion_strip: Promotion?
    var module_list = [Module]()
}

struct Promotion: HandyJSON {
    var title: String?
    var url: String?
}

struct iconImg: HandyJSON {
    var left_top_night_icon: String?
    var left_top_day_icon: String?
}

struct Content: HandyJSON {
    var authors = [User]()
    var icons: iconImg?
    var chapter_text: String?
    var producer: String?
    var artwork: String?
    var description: String?
    var duration_text: String?
    var is_started: Bool = false
    var business_id: String?
    var tag_before_title: String?
    var title: String?
    var id: String?
    
    // type 24 (今日限免 & 折扣)
    var discount_price: Int = 0
    var label_text: String?
    var ownership: Bool = false
    var finished_at: String?
    var tab_artwork: String?
    var price: Double = 0.0
    var started_at: String?
    var sku_id: String?
    var discount_type: String?
    var button_text: String?
    var channel_key: String?
    var is_coupon_received: Bool = false
     
    // type 2 (为你讲书)
    var media_id: String?
    var summary: String?
    var interest_count: Int = 0
    var has_subscribed: Bool = false
    
    // type 22 (盐选榜单)
    var rank_name : String?
    var data = [RankData]()
}

struct RankData : HandyJSON {
    var sku_type: String?
    var tag_before_title: String?
    var subcategory_cn: String?
    var description: String?
    var promotion_price: Int = 0
    var subcategory: String?
    var heat: Int = 0
    var tab_artwork: String?
    var chapter: Int = 0
    var title: String?
    var summary: String?
    var sku_id: String?
    var duration_text: String?
    var price: Int = 0
    var svip_privileges: Bool = false
    var business_id: String?
    var duration: Int = 0
    var artwork: String?
    var chapter_text: String?
    var author = [String]()
    var icons: iconImg?
    var can_experience: Bool = false
    var online_time: Int = 0
    var is_started: Bool = false
    var extra: String?
    var image = [String]()
    var producer: String?
    var interest_count: Int = 0
    var author_desc: String?
    var media_type: String?
}

