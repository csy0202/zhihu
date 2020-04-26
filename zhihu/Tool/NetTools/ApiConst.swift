//
//  ApiConst.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/16.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation

struct Api {
    /// 首页-关注
    static let moments = "/moments"
    /// 首页-热榜
    static func hotList(path: String = "") -> String {
        var url = "/topstory/hot-lists"
        if path.count > 0 {
            url += "/\(path)"
        }
        return url
    }
    /// 会员
    static let marketHeader = "/market/header"
    /// 会员 - banner
    static let marketVipRecommendHeader = "/market/vip_recommend/header"
    /// 会员 - 热门推荐
    static let marketVipRecommendCategories = "/market/vip_recommend/categories"
    /// 会员 - 发现更多
    static let marketRecommendationsInterest = "/market/recommendations/interest"
}

let baseUrl = "https://api.zhihu.com"

let headers : [String:String] = ["Content-type" : "application/json",
"cookie":"KLBRSID=57358d62405ef24305120316801fd92a|1586853990|1586853844; _xsrf=ceMpvDxyk50JIfFFgjvzshEw60AZRNwS; q_c1=1c9ee22a127146d4a71ee707b2a1f6f2|1545795861000|1545795861000; _zap=61f2fbe9-3222-47e0-bb00-2c32a21ff3c0; Hm_lvt_98beee57fd2ef70ccdd5ca52b9740c49=1586423144,1586748037,1586751948,1586757964; q_c0=2|1:0|10:1586843452|4:q_c0|80:MS4xYl9TckJnQUFBQUFMQUFBQVlBSlZUVHpjdkY0aWpTVVl6U0hJZS10LWhWNnZ1SWFscWwtLV9nPT0=|cff2102a02368cc0b2a9e582c7cdf2742f8a82299abb393090da08613131033a; z_c0=2|1:0|10:1586843452|4:z_c0|80:MS4xYl9TckJnQUFBQUFMQUFBQVlBSlZUVHpjdkY0aWpTVVl6U0hJZS10LWhWNnZ1SWFscWwtLV9nPT0=|8ec8c8d319a1f3eb763d7e5b7eb62521515044a7be0b99b58abd1d70d6623e07; d_c0=AIACoYwyvwxLBeYh-iZOsl7sBbW0ca8_870=|1586843451; zst_82=2.0AFCWqD8LHhELAAAASwUAADIuMGZ4lV4AAAAA_hS-PBO0O2nt_XjnrQ0LO8V7Sxk="]


