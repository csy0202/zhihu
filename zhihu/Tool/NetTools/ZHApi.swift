//
//  ZHApi.swift
//  zhihu
//
//  Created by 陈淑洋 on 2020/4/3.
//  Copyright © 2020 chensy. All rights reserved.
//

import Foundation
import Moya
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
    case momentsLastread
    case hotList(parameDic:[String:Any] = [:],path:String = "") // 热榜
//    case hotListsTotal(parameDic:[String:Any]) // 热搜全部
}

extension ZHApi : TargetType {
    var baseURL: URL {
        return URL(string: "https://api.zhihu.com")!
    }
    var path: String {
        switch self {
        case .moments(_):
            return "/moments"
        case .momentsLastread:
            return "/moments/lastread"
        case .hotList(_, let path):
            var url = "/topstory/hot-lists"
            if path.count > 0 {
                url += "/\(path)"
            }
            return url
//        case .hotListsTotal(_):
//            return "/topstory/hot-lists/total"
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
        case .hotList(let dic, _):
            customParaDic = dic
        default : break
        }
        return .requestParameters(parameters: customParaDic, encoding: JSONEncoding.default)
    }

    var headers: [String : String]? {
       return ["Content-type" : "application/json",
               "cookie":"KLBRSID=4843ceb2c0de43091e0ff7c22eadca8c|1587032333|1587030091; zst_82=2.0AABUfSauIBELAAAASwUAADIuMIArmF4AAAAAWqS485YiQdPyjsxt05g4Pk4VTNI=; Hm_lpvt_98beee57fd2ef70ccdd5ca52b9740c49=1587030104; d_c0=AIACoYwyvwxLBeYh-iZOsl7sBbW0ca8_870=|1587030091; q_c0=2|1:0|10:1586843452|4:q_c0|80:MS4xYl9TckJnQUFBQUFMQUFBQVlBSlZUVHpjdkY0aWpTVVl6U0hJZS10LWhWNnZ1SWFscWwtLV9nPT0=|cff2102a02368cc0b2a9e582c7cdf2742f8a82299abb393090da08613131033a; z_c0=2|1:0|10:1586843452|4:z_c0|80:MS4xYl9TckJnQUFBQUFMQUFBQVlBSlZUVHpjdkY0aWpTVVl6U0hJZS10LWhWNnZ1SWFscWwtLV9nPT0=|8ec8c8d319a1f3eb763d7e5b7eb62521515044a7be0b99b58abd1d70d6623e07; Hm_lvt_98beee57fd2ef70ccdd5ca52b9740c49=1586748037,1586751948,1586757964,1586934488; _xsrf=ceMpvDxyk50JIfFFgjvzshEw60AZRNwS; _zap=61f2fbe9-3222-47e0-bb00-2c32a21ff3c0; q_c1=1c9ee22a127146d4a71ee707b2a1f6f2|1545795861000|1545795861000"]
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
    // 单例(requestClosure : requestClosure)
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
