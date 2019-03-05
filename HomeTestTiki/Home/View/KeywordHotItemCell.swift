//
//  KeywordHotItemCell.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import SDWebImage
import Reusable

class KeywordHotItemCell: UICollectionViewCell,NibReusable {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var keywordLabel: UILabel!
    var keyword : Keyword? {
        didSet {
            guard let kw = keyword else {return}
            self.thumbImageView.sd_setImage(with: URL.init(string:kw.icon ?? "" ), completed: nil)
            self.keywordLabel.text = kw.keyword
            self.keywordLabel.backgroundColor = UIColor.init(hex: kw.color ?? "")
            self.keywordLabel.layer.cornerRadius = 5
            self.keywordLabel.clipsToBounds = true
            
        }
    }
    

}
