//
//  ZHApi.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/3.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import Moya
//https://api.zhihu.com/moments/recommend?action=up&session_id=3db4e050a6bbe782dc01e54d75d654e4&feed_type=all&reverse_order=0&scroll=up
private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}
let ZHApiProvider = MoyaProvider<ZHApi>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

enum ZHApi {
    case moments(parameDic:[String:Any]) // 关注列表
}

extension ZHApi : TargetType {
    var baseURL: URL {
        return URL(string: "https://api.zhihu.com")!
    }
    var path: String {
        switch self {
        case .moments(_):
            return "/moments"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        var customParaDic : [String : Any] = [:]
        switch self {
        case .moments(let dic):
            customParaDic = dic
        }
        return .requestParameters(parameters: customParaDic, encoding: JSONEncoding.default)
    }

    var headers: [String : String]? {
       return ["Content-type" : "application/json",
               "cookie":"KLBRSID=ed2ad9934af8a1f80db52dcb08d13344|1585898069|1585896308; _xsrf=ceMpvDxyk50JIfFFgjvzshEw60AZRNwS; q_c1=1c9ee22a127146d4a71ee707b2a1f6f2|1545795861000|1545795861000; _zap=61f2fbe9-3222-47e0-bb00-2c32a21ff3c0; Hm_lvt_98beee57fd2ef70ccdd5ca52b9740c49=1583380225,1585641305; q_c0=2|1:0|10:1584878816|4:q_c0|80:MS4xYl9TckJnQUFBQUFMQUFBQVlBSlZUZURobmw2cmxhZ2NiOFU1T3JtMUhNekJCS3VrQmFuM0ZRPT0=|ce5088a0adcdac35ec9bb1e6ffca61f970cb97157fcdba7d9c483e6fe3d277d2; z_c0=2|1:0|10:1584878816|4:z_c0|80:MS4xYl9TckJnQUFBQUFMQUFBQVlBSlZUZURobmw2cmxhZ2NiOFU1T3JtMUhNekJCS3VrQmFuM0ZRPT0=|f1f6d9e589f6e030453a33d0982fef62dc5d2b2d16d45673850917ddd73a25ed; zst_82=2.0AJBTjBTLDxELAAAASwUAADIuMK3ghl4AAAAAoDiD-nUfVsgnK701Dz3lxvJBnj8="]
    }
}

let requestClosure = { (endpoint: Endpoint, closure: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 30
        closure(.success(request))
        
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        
        
        
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}
struct NetProvider {
    // 请求成功的回调
    typealias successCallback = (_ result: String) -> Void
    // 请求失败的回调
    typealias failureCallback = (_ error: MoyaError) -> Void
    // 单例
    static let provider = MoyaProvider<ZHApi>(requestClosure : requestClosure)
    static func request(target:ZHApi,success:@escaping successCallback , failure:@escaping failureCallback){
        provider.request(target) { (result) in
            switch result {
            case let .success(moyaResponse):
                do {
                    let returnData = String(data: moyaResponse.data, encoding: String.Encoding.utf8)!
                    print("请求成功\(returnData)") // 测试用JSON数据
                    success(returnData)
                } catch {
                    failure(MoyaError.jsonMapping(moyaResponse))
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
