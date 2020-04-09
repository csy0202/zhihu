//
//  RecommendModel.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/9.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import HandyJSON
//struct RecommendModel: HandyJSON {
//    var data = [Data]()
//    var fresh_text: String?
//    var paging: Paging?
//}
//
////struct Paging: HandyJSON {
////    var next: String?
////    var is_end: Bool = false
////    var previous: String?
////}
//
//struct Extra: HandyJSON {
//    var id: String?
//    var type: String?
//}
//
//struct Common_card: HandyJSON {
//    var footline: Footline?
//    var action: Action?
//    var feed_content: Feed_content?
//    var style: String?
//    var version: String?
//    var ellipsis_menu: Ellipsis_menu?
//}
//
//struct Ellipsis_menu: HandyJSON {
//    var items = [Items]()
//}
//
//struct Raw_button: HandyJSON {
//    var text: Text?
//    var style: String?
//    var icon: Icon?
//    var action: Action?
//}
//
//struct Action: HandyJSON {
//    var method: String?
//    var view_info: String?
//    var intent_url: String?
//}
//
//struct Icon: HandyJSON {
//    var height: Int = 0
//    var mask_filter_type: String?
//    var width: Int = 0
//    var image_url: String?
//}
//
//struct Text: HandyJSON {
//    var max_line: Int = 0
//    var size: Int = 0
//    var weight: String?
//    var panel_text: String?
//    var color: String?
//}
//
//struct Feed_content: HandyJSON {
//    var source_line: Source_line?
//    var content: Content?
//    var title: Title?
//}
//
//struct Title: HandyJSON {
//    var panel_text: String?
//    var color: String?
//    var max_line: Int = 0
//    var weight: String?
//    var size: Int = 0
//    var action: Action?
//}
//
//struct Action: HandyJSON {
//    var method: String?
//    var intent_url: String?
//    var view_info: String?
//}
//
//struct Content: HandyJSON {
//    var panel_text: String?
//    var color: String?
//    var size: Int = 0
//    var max_line: Int = 0
//    var weight: String?
//}
//
//struct Source_line: HandyJSON {
//    var elements = [Elements]()
//}
//
//struct Avatar: HandyJSON {
//    var image: Image?
//}
//
//struct Image: HandyJSON {
//    var mask_filter_type: String?
//    var image_url: String?
//    var height: Int = 0
//    var width: Int = 0
//}
//
//struct Action: HandyJSON {
//    var view_id: Int = 0
//    var view_info: String?
//    var method: String?
//    var intent_url: String?
//}
//
//struct Footline: HandyJSON {
//    var elements = [Elements]()
//}
//
//struct Text: HandyJSON {
//    var panel_text: String?
//    var color: String?
//    var size: Int = 0
//    var max_line: Int = 0
//    var weight: String?
//}
//
//struct Uninterest_reasons: HandyJSON {
//    var success_text: String?
//    var reason_text: String?
//    var object_token: String?
//    var object_type: String?
//    var reason_type: String?
//    var reason_id: Int = 0
//}
//
//struct Elements: HandyJSON {
//    var text: Text?
//}
//
//struct Elements: HandyJSON {
//    var avatar: Avatar?
//}
//
//struct Items: HandyJSON {
//    var raw_button: Raw_button?
//}
//
//struct Data: HandyJSON {
//    var id: String?
//    var offset: Int = 0
//    var brief: String?
//    var brand_promotion_extra: String?
//    var uninterest_reasons = [Uninterest_reasons]()
//    var attached_info: String?
//    var type: String?
//    var promotion_extra: String?
//    var common_card: Common_card?
//    var extra: Extra?
//}
