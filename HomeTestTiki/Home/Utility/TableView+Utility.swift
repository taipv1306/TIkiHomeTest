//
//  TableView+Utility.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell(viewModel : HomeSectionItemViewModel , indexPath : IndexPath) -> BaseCell {
        return self.dequeueReusableCell(withIdentifier: viewModel.sectionType.rawValue, for: indexPath) as! BaseCell
    }
    
}
