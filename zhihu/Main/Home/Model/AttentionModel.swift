//
//  AttentionModel.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/2.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import HandyJSON

struct AttentionModel: HandyJSON {
    var data : [Article] = []
    var paging: Paging?
    var session_id: String = ""
    var fresh_text: String = ""
}
struct Article: HandyJSON {
    var target_type: String = ""
    var target: Target_zh?
    var type: String = ""
    var source: Source?
    var brief: String = ""
    var interaction: Interaction?
    var attached_info: String = ""
}
struct Target_zh: HandyJSON {
    var voteup_count: Int = 0
    var url: String = ""
    var comment_count: Int = 0
    var label_info: Label_info?
    var author: Auth?
    var excerpt: String = ""
    var type: String = ""
    var relationship: Relationship_zh?
    var thumbnail: String = ""
    var thumbnail_extra_info : Thumbnail_extra_info?
    var id: Int = 0
    var question: Question?
    var title : String = ""
    var image_url : String = ""
    var voting : Int = 0
    
}

struct Thumbnail_extra_info: HandyJSON {
    var duration: Float = 0.0
    var width: Int = 0
    var video_id: Int = 0
    var customized_page_url: String?
    var type: String?
    var playlist: Playlist?
    var simplified_card_json: String?
    var url: String?
    var height: Int = 0
}

struct Playlist: HandyJSON {
    var ld: Ld?
    var hd: Ld?
    var sd: Ld?
}
struct Ld: HandyJSON {
    var size: Int = 0
    var width: Int = 0
    var height: Int = 0
    var url: String?
}


struct Source: HandyJSON {
    var action_time: Double = 0
    var source_desc: String = ""
    var actor: Actor?
    var action_text: String = ""
    var action_type: String = ""
}
struct Actor: HandyJSON {
    var user_type: String = ""
    var url_token: String = ""
    var is_followed: Bool = false
    var is_org: Bool = false
    var vip_info: VipInfo?
    var badge = [Badge]()
    var id: String = ""
    var name: String = ""
    var is_following: Bool = false
    var type: String = ""
    var headline: String?
    var gender: Int = 0
    var url: String = ""
    var avatar_url: String = ""
}
struct VipInfo: HandyJSON {
    var is_vip: Bool = false
    var vip_icon: VipIcon?
    var widget: Widget?
}
struct VipIcon: HandyJSON {
    var url: String = ""
    var night_mode_url: String?
}

struct Paging: HandyJSON {
    var is_end: Bool = false
    var previous: String = ""
    var next: String = ""
}

struct Interaction: HandyJSON {
    var can_show_other_activity: Bool = false
    var can_delete: Bool = false
    var can_recent_top: Bool = false
}
struct Widget: HandyJSON {
    var id: Int = 0
    var url: String?
    var night_mode_url: String?
}
struct Question: HandyJSON {
    var excerpt: String?
    var id: Int = 0
    var type: String?
    var title: String?
    var url: String?
    var follower_count: Int = 0
    var answer_count: Int = 0
}

struct Relationship_zh: HandyJSON {
    var voting: String?
}

struct Auth: HandyJSON {
    var user_type: String?
    var url_token: String?
    var is_followed: Bool = false
    var is_org: Bool = false
    var vip_info: VipInfo?
    var id: String?
    var name: String?
    var is_following: Bool = false
    var type: String?
    var headline: String?
    var gender: Int = 0
    var url: String?
    var avatar_url: String?
}

struct Label_info: HandyJSON {
    var foreground_color: Foreground_color?
    var text: String?
    var type: String?
}

struct Foreground_color: HandyJSON {
    var alpha: Float = 0.0
    var group: String?
}

struct Badge: HandyJSON {
    var type: String?
    var description: String?
    var topic_names = [String]()
}


