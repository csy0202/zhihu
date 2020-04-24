//
//  Network.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/16.
//  Copyright © 2020 chensy. All rights reserved.
//

import Alamofire
struct Network {
    // 请求成功的回调
    typealias successCallback = (_ result: String) -> ()
    // 请求失败的回调
    typealias failureCallback = (_ error: Error) -> ()

    static func request(api
        :String , parame : [String:Any] = [:] , method :HTTPMethod = .get ,
        success:@escaping successCallback , failure:@escaping failureCallback){
        let url = baseUrl + api
        Alamofire.request(url, method: method, parameters: parame,headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseString{ (response) in
            switch response.result {
            case .success(_):
                let returnData = String(data: response.data!, encoding: String.Encoding.utf8)!
                print("请求成功\(returnData)")
                success(returnData)
            case .failure(_):
                failure(response.error!)
            }
        }
    }
}
