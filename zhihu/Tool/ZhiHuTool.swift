//
//  ZhiHuTool.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/9.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func getParameter(url:String?) -> [String:Any] {
        guard let url = url else { return [:] }
        let arr = url.components(separatedBy: "?")
        if arr.count == 2 {
            let arr1 = arr[1].components(separatedBy: "&")
            var dic : [String : Any] = [:]
            for str in arr1 {
                let a = str.components(separatedBy: "=")
                dic[a[0]] = a[1]
            }
            return dic
        }
        return [:]
    }
}

