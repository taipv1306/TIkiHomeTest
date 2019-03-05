//
//  KeywordHotCell.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class KeywordHotCell: BaseCell,NibReusable {
    @IBOutlet var hotkeywordsCollectionView : UICollectionView!
    override var viewModel : HomeSectionItemViewModel? {
        didSet {
            guard let vm = viewModel  else {return}
            let disposeBag = DisposeBag()
            vm.itemDriver.map { e -> [Keyword] in
                if let keywords : [Keyword] = e as? [Keyword] {return keywords}
                return []}
                .drive(self.hotkeywordsCollectionView.rx.items(cellIdentifier: "KeywordHotItemCell" ,
                                                               cellType: KeywordHotItemCell.self))
                { (_,data,cell) in
                                                                cell.keyword = data
                    
                }.disposed(by: disposeBag)
            self.hotkeywordsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
            self.disposeBag = disposeBag

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.hotkeywordsCollectionView.register(cellType: KeywordHotItemCell.self)
    }
    
    
}

extension KeywordHotCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightCell : CGFloat = 177
        let heightLabel : CGFloat = 57
        let defaultWidth : CGFloat = 121
        guard let keywords = self.viewModel?.item as? [Keyword] else {return CGSize(width: 188, height: heightCell) }
        let textAtIndex = keywords[indexPath.row]
        let data : (CGFloat,String)? = (textAtIndex.keyword ?? "").caculatorMinWidth(withConstrainedHeight: heightLabel, font: UIFont.systemFont(ofSize: 14))

        
        return CGSize(width: data?.0 ?? defaultWidth , height: heightCell)
    }

}
