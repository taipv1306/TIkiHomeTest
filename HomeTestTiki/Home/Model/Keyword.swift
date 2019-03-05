//
//  Keyword.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import ObjectMapper

class Keyword: Mappable {
    var keyword      : String?
    var icon         : String?
    var color        : String?
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        keyword        <- map[ParamsReponseAPI.keyword]
        icon           <- map[ParamsReponseAPI.icon]
    }
    
    func convertToHomeSectionItem(sectionType : HomeSectionType = HomeSectionType.recommendKeywordHot ) -> HomeSectionItemViewModel {
        return HomeSectionItemViewModel(item: self , sectionType : sectionType )
    }
}
