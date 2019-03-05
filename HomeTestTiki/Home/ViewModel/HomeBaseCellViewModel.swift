//
//  HomeBaseCellViewModel.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

protocol HomeBaseModelProtocol {
    associatedtype TypeInput
    var type : HomeSectionType { get set }
}


class HomeBaseCellViewModel {
    var result : Any
    var type    : HomeSectionType
    init(type : HomeSectionType , data : Any) {
        self.type = type
        result = data
    }

}
