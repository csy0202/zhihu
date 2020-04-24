//
//  TopicModel.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/12.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import HandyJSON

struct TopicList: HandyJSON {
    var data = [TopicModel]()
    var fresh_text: String?
    var paging: Paging?
}

struct TopicModel: HandyJSON {
    var card_id: String?
    var id: String?
    var detail_text: String?
    var debut: Bool = false
    var type: String?
    var trend: Int = 0
    var style_type: String?
    var attached_info: String?
    var target: TopicTarget?
    var children = [Children]()

}


struct TopicTarget: HandyJSON {
    var id: Int = 0
    var is_following: Bool = false
    var title: String?
    var follower_count: Int = 0
    var type: String?
    var created: Int = 0
    var author: User?
    var url: String?
    var bound_topic_ids = [Int]()
    var comment_count: Int = 0
    var excerpt: String?
    var answer_count: Int = 0
}

struct Children: HandyJSON {
    var type: String?
    var thumbnail: String?
}
