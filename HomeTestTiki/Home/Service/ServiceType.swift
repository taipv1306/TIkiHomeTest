//
//  ServiceType.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Alamofire


enum ValueResult<T> {
    case ok(T)
    case loading
    case error(GenericError)
    
    func isSuccess() -> Bool  {
        switch self {
        case .ok(_) : return true
        default : return false
        }
    }
    func result() -> T? {
        switch self {
        case .ok(let data ):return data
        default: return nil
        }
    }
    func isError() -> GenericError? {
        switch self {
        case .error(let error): return error
        default: return nil
        }
    }
    
}


class TikiProvider<Target> where Target: Moya.TargetType {
     let online: Observable<Bool>
     let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Observable<Bool> = connectedToInternet()) {
        
        self.online = online
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
    
    func request(_ api: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(api)
        return Observable.just(1)
            .flatMap { _ in
                return actualRequest
        }
    }

}

protocol ServiceType {
    associatedtype T: TargetType
    var provider: TikiProvider<T> { get }
}


extension ServiceType {
    
    static func endpointsClosure<T>() -> (T) -> Endpoint where T: TargetType {
        return { target in
            var endpoint: Endpoint = Endpoint(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: nil)
            
            
            //Add content type
            endpoint = endpoint.adding(newHTTPHeaderFields: [ParamsHeaderAPI.cotentType: ValueHeaderAPI.CotentType.json])
        
            //Add app version
            if let versionInfo = Bundle.main.infoDictionary {
                let appVersion = versionInfo["CFBundleShortVersionString"] as? String ?? "Unknown"
                endpoint = endpoint.adding(newHTTPHeaderFields: [ParamsHeaderAPI.appVersion : appVersion])
            }
            
            if let headerService : [String : String] = target.headers {
                endpoint = endpoint.adding(newHTTPHeaderFields: headerService)
            }
            
            return endpoint
        }
    }
    
    static func newDefaultStubBehavior<T>(_: T) -> Moya.StubBehavior {
        return .never
    }
    
    static var plugins: [PluginType] {
        return [NetworkLogger()]
    }

    
    // (Endpoint, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch let error {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
    
    static func url(_ api: TargetType) -> String {
        return api.baseURL.appendingPathComponent(api.path).absoluteString
    }
    
}
