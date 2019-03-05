//
//  BaseCell.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxDataSources

class BaseCell: UITableViewCell {
    var viewModel : HomeSectionItemViewModel?
    var disposeBag: DisposeBag?
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
        self.disposeBag = nil
    }


}
