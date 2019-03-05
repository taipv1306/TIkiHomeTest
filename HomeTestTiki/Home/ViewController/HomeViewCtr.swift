//
//  HomeViewCtr.swift
//  HomeTestTiki
//
//  Created by ZickOne on 3/4/19.
//  Copyright © 2019 TaiPham. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SVPullToRefresh

typealias HomeDatSource = RxTableViewSectionedAnimatedDataSource<HomeSection>

class HomeViewCtr: BaseViewCtr,ViewModelHasTableBased {
    typealias ViewModelType = HomeViewModel
    
    var viewModel: ViewModelType!
    var dataSource : HomeDatSource!
    @IBOutlet var homeTableview : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let vm = HomeViewModel.init(input: HomeViewModel.Input(refreshTrigger : Variable(())),
                                    dependency: HomeViewModel.Dependency(service : HomeService()))
        
        viewModel = vm
        registerCell()
        configDs()
        if let input = viewModel.input {bindingInput(input: input)}
        if let output = viewModel.output {bindingOutput(output: output)}
        self.title = "Tike Home Test"


    }
    
    func registerCell() {
        self.homeTableview.register(cellType: KeywordHotCell.self)
        self.homeTableview.register(cellType: KeywordRecommendCell.self)
    }
    
    func configDs() {
        self.dataSource = HomeDatSource.init(configureCell: { (ds, tv, indexPath, element) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(viewModel: element, indexPath: indexPath)
            cell.viewModel = element
            return cell
        })
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            let section = dataSource[sectionIndex]
            return section.identity.title ?? ""
        }
        
        self.homeTableview.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func bindingInput(input: HomeViewModel.Input) {
        self.homeTableview.addPullToRefresh { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.input?.refreshTrigger.value = ()
        }

    }
    
    func bindingOutput(output: HomeViewModel.Output) {
        output.result.map{$0.result() ?? []}.drive(self.homeTableview.rx.items(dataSource: self.dataSource)).disposed(by: disposeBag)
        
        output.result
            .drive(onNext: { [weak self] data in
                self?.homeTableview.pullToRefreshView.stopAnimating()
            })
            .disposed(by: disposeBag)

    }
    
}


extension HomeViewCtr : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        header.textLabel?.textColor = NSString.share.color.mainColor
        header.textLabel?.font  = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.medium)
        
        header.textLabel?.backgroundColor = .white
        header.backgroundView?.backgroundColor = .white
        
    }
}
