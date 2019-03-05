import RxSwift
import ObjectMapper
import AlamofireObjectMapper
import Moya
//
//  HomeService.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
public enum HomeAPI {
    case keywordHot
    case recommendKeywordHot
}
extension HomeAPI : TargetType {
    
    public var baseURL: URL { return URL(string: "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com")! }
    
    public var path: String {
        switch self {
            case .keywordHot : return "/ios/keywords.json"
            case .recommendKeywordHot :  return "/ios/keywords.json"
        }
    }
    
    public var task: Task {
        switch self {
        case .keywordHot:  return Task.requestParameters(parameters: [:], encoding: URLEncoding.default)
        default : return Task.requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .keywordHot : return .get
        default : return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return nil
    }
}


class HomeService : ServiceType, HomeServiceProtocol {
    
    typealias T = HomeAPI
    
    var provider: TikiProvider<HomeAPI>

    init() {
        provider = TikiProvider<HomeAPI>.init(endpointClosure: HomeService.endpointsClosure(),
                                               requestClosure: HomeService.endpointResolver(),
                                               stubClosure: HomeService.newDefaultStubBehavior,
                                               plugins: HomeService.plugins)
    }
    
    func keywordHot() -> Observable<ValueResult<[Keyword]>> {
        return provider.request(.keywordHot).map { response in
            if let jsonRaw : [String : Any]  = (try? response.mapJSON(failsOnEmptyData: true)) as? [String : Any] {
                if let raw :  [[String : Any]] = jsonRaw[ParamsReponseAPI.listKeyword] as? [[String : Any]] {
                    let keywords : [Keyword] = Mapper<Keyword>().mapArray(JSONArray: raw)
                    return  ValueResult.ok(keywords)
                }
            }
            return ValueResult.ok([])
        }
    }
    
    func recommenKeyword() -> Observable<ValueResult<[Keyword]>> {
        return provider.request(.recommendKeywordHot).map { response in
            if let jsonRaw : [String : Any]  = (try? response.mapJSON(failsOnEmptyData: true)) as? [String : Any] {
                if let raw :  [[String : Any]] = jsonRaw[ParamsReponseAPI.listKeyword] as? [[String : Any]] {
                    let keywords : [Keyword] = Mapper<Keyword>().mapArray(JSONArray: raw)
                    return  ValueResult.ok(keywords)
                }
            }
            return ValueResult.ok([])
        }
    }


}

