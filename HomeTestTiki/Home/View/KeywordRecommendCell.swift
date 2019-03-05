//
//  KeywordRecommendCell.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage
import RxSwift
import RxCocoa

class KeywordRecommendCell: BaseCell,NibReusable {
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var pastelView: UIView!
    
    
    override var viewModel : HomeSectionItemViewModel? {
        didSet {
            guard let vm = viewModel  else {return}
            guard let kw : Keyword =  vm.item as? Keyword else {return}

            self.keywordLabel.text = kw.keyword
            self.keywordLabel.setNeedsDisplay()
            self.keywordLabel.layoutIfNeeded()
            self.thumbImageView.sd_setImage(with: URL(string: kw.icon ?? ""), completed: nil)
            self.pastelView.backgroundColor = UIColor(hex: kw.color ?? "")

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pastelView.layer.cornerRadius = 5
        thumbImageView.layer.cornerRadius = 24
        thumbImageView.clipsToBounds = true
        self.pastelView.clipsToBounds = true

        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
