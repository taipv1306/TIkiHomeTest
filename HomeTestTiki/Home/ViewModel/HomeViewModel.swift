//
//  HomeViewModel.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class HomeViewModel : ViewModelProtocol {
    
    struct Input {
        var refreshTrigger   : Variable<()>
    }
    
    struct Output {
        var result : Driver<ValueResult<[HomeSection]>>
    }
    
    struct Dependency {
        var service : HomeService?
    }

    
    var input: HomeViewModel.Input?
    
    var output: HomeViewModel.Output?
    
    var dependency: HomeViewModel.Dependency?
    
    init(input : Input? , dependency : Dependency?) {
        self.input = input
        self.dependency = dependency
        self.output = transform(input: self.input, dependency: self.dependency)
    }

    
    @discardableResult
    func transform(input: HomeViewModel.Input?, dependency: HomeViewModel.Dependency?) -> HomeViewModel.Output? {
        
        guard let ip = input , let dpy = dependency else {return nil}
        guard let lService = dpy.service else { return nil}
        
        
        let keywordHotObs : Observable<ValueResult<[Keyword]>>  = ip.refreshTrigger.asObservable()
            .debounce(0.3, scheduler: MainScheduler.instance).flatMapLatest{lService.keywordHot()}
        
        let keywordRecommendObs : Observable<ValueResult<[Keyword]>>  = ip.refreshTrigger.asObservable()
            .debounce(0.3, scheduler: MainScheduler.instance).flatMapLatest{lService.recommenKeyword()}

        
        
        
        let result : Observable<ValueResult<[HomeSection]>> = Observable.combineLatest(keywordHotObs,keywordRecommendObs).map { arg -> ValueResult<[HomeSection]> in
           
            if let keywordHotError =  arg.0.isError() , let _ = arg.1.isError() {
                    return ValueResult.error(keywordHotError)
            }
            //
            var listSection : [HomeSection] = []
           
            if var keywordsHot = arg.0.result() , keywordsHot.count > 0 {
                var colors = ["16702e","005a51","996c00","5c0a6b","006d90","974e06","99272e","89221f","00345d"]

                keywordsHot = keywordsHot.map{ kw in
                    let popColor = colors.removeFirst()
                    kw.color = popColor
                    colors.append(popColor)
                    return kw
                }
                let keywordHotSection = HomeSection(type: HomeSectionType.keywordHot, items: [HomeSectionItemViewModel(item: keywordsHot,
                                                                                                                       sectionType : HomeSectionType.keywordHot )])
                listSection.append(keywordHotSection)
            }
            
            if var keywordsRecommend = arg.1.result() , keywordsRecommend.count > 0 {
                var colorsRecommend  = ["f54ea2","ff7676","17ead9","1bcedf","f02fc2"]
                keywordsRecommend = keywordsRecommend.map{ kw in
                    let popColor = colorsRecommend.removeFirst()
                    kw.color = popColor
                    colorsRecommend.append(popColor)
                    return kw
                }

                
                let keywordHotSection = HomeSection(type: HomeSectionType.recommendKeywordHot,
                                                    items: keywordsRecommend.map{$0.convertToHomeSectionItem()})
                listSection.append(keywordHotSection)
            }
            return ValueResult.ok(listSection)
        }
        return HomeViewModel.Output(result: result.asDriver(onErrorJustReturn: ValueResult<[HomeSection]>.error(GenericError.defaultError())))
    }
    
    @discardableResult
    func updateInput(input: HomeViewModel.Input?) -> HomeViewModel.Output? {
        return nil
    }
    @discardableResult
    func updateDependecy(dependency: HomeViewModel.Dependency?) -> HomeViewModel.Output? {
        return nil
    }
}

///
///
//

enum HomeSectionType : String {
    case keywordHot                   = "KeywordHotCell"
    case recommendKeywordHot          = "KeywordRecommendCell"
    
    var title : String? {
        switch self {
        case .keywordHot: return "Từ Khoá Hot"
        default: return "Từ Khoá Gợi Ý"
        }
    }
}

struct HomeSection {
    var type : HomeSectionType
    var _items : [HomeSectionItemViewModel]
    
    init(type: HomeSectionType, items: [HomeSectionItemViewModel]) {
        self.type = type
        self._items = items
    }
}

extension HomeSection: AnimatableSectionModelType {
    typealias Item = HomeSectionItemViewModel
    
    typealias Identity = HomeSectionType
    
    var identity: HomeSectionType {
        return type
    }
    
    var items: [HomeSectionItemViewModel] {
        return self._items
    }
    
    init(original: HomeSection, items: [HomeSectionItemViewModel]) {
        self = original
        self._items = items
    }
}


struct HomeSectionItemViewModel : Equatable, IdentifiableType {
    typealias Identity = String
    
    private var _identity : String = UUID().uuidString
    
    var item : Any
    var itemDriver : Driver<Any>
    var sectionType : HomeSectionType
    var identity: String {
        return _identity
    }
    
    init(item: Any,sectionType : HomeSectionType ) {
        self.item = item
        itemDriver = Driver.just(item)
        self.sectionType = sectionType
    }
    
    static func == (lhs: HomeSectionItemViewModel, rhs: HomeSectionItemViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }
    
}

