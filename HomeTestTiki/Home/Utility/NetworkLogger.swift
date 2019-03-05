//
//  NetworkLogger.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import Moya
import Result

class NetworkLogger: PluginType {
    func willSendRequest(_ request: RequestType, target: TargetType) {
        logger.log("Sending request: \(request.request?.url?.absoluteString ?? String())")
    }
    
    func didReceiveResponse(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if 200..<400 ~= (response.statusCode ) {
                // If the status code is OK, don't worry about logging its response body.
                logger.log("Received response(\(response.statusCode )) from \(response.response?.url?.absoluteString ?? String()).")
            }
        case .failure(let error):
            // Otherwise, log everything.
            logger.log("Received networking error: \(error)")
        }
    }
}
