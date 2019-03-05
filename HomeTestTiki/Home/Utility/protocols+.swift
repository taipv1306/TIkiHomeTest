//
//  protocols+.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency
    
    var input      : Input? { get set }
    var output     : Output? { get set }
    var dependency : Dependency? { get set }
    @discardableResult
    func transform(input: Input?, dependency: Dependency?) -> Output?
    @discardableResult
    func updateInput(input: Input?) -> Output?
    @discardableResult
    func updateDependecy(dependency: Dependency?) -> Output?
}

protocol ViewModelBased: class {
    associatedtype ViewModelType: ViewModelProtocol
    var viewModel: ViewModelType! { get set }
    func bindingOutput(output : Self.ViewModelType.Output)
}

protocol ViewModelHasTableBased: class {
    associatedtype ViewModelType: ViewModelProtocol
    var viewModel: ViewModelType! { get set }
    func registerCell()
    func configDs()
    func bindingInput(input : Self.ViewModelType.Input)
    func bindingOutput(output : Self.ViewModelType.Output)
}

protocol HomeServiceProtocol {
    func keywordHot() -> Observable<ValueResult<[Keyword]>>
    func recommenKeyword() -> Observable<ValueResult<[Keyword]>>

}

protocol JSONAbleType {
    static func fromJSON(_: [String: Any]) -> Self?
    func toJSON() -> [String:Any]?
}
