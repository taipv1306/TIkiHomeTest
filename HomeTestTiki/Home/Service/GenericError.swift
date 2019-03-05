//
//  GenericError.swift
//  XtripPartner
//
//  Created by Tai Pham on 7/18/18.
//  Copyright © 2018 Tai Pham. All rights reserved.
//

import UIKit
enum TikiAPIError : Error {
    case `default`
    
}

class GenericError : NSObject  {
    let detail: [String:AnyObject]
    let message: String
    let type: Error
    
    required init(type: Error, message: String, detail: [String:AnyObject]) {
        self.detail = detail
        self.message = message
        self.type = type
    }
    
    override convenience init() {
        self.init(type: TikiAPIError.default, message: "", detail: [:])
    }
}

extension GenericError : JSONAbleType {
    func toJSON() -> [String : Any]? {
        return nil
    }
    
    static func fromJSON(_: [String : Any]) -> Self? {
        return nil
    }
    
    static func defaultError() -> Self {
        return self.init(type: TikiAPIError.default, message: "message", detail: [:])
    }
 }
