//
//  SearchViewController.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController, SearchViewInput {
    
    var output: SearchViewOutput!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var bag:DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bag =  DisposeBag()

        // Do any additional setup after loading the view.
        self.output.viewIsReady()
        self.indicator.isHidden = true
        initViewController()
    }
    
    private func initViewController() {
        self.searchBar
            .rx.text
            .orEmpty  
            .debounce(0.15, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in
                self.output.searchString.value = query
            })
            .disposed(by: bag!)
        
        self.output.photos
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "SearchViewCell", cellType: SearchViewCell.self)){
                (row,photo,cell) in
                 cell.setCellData(data: photo)
            }.disposed(by: self.bag)
        
        
        self.tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if  let photo = self?.output.photos.value[indexPath.row] {
                    self?.output.pushOnDetail(photo: photo) }
            }).disposed(by: self.bag!)
    }
    
    func showLoader() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }
    
    func hideLoader() {
        
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.bag = nil
    }
    
}
