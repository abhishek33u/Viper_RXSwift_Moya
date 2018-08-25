//
//  SearchPresenter.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchPresenter: SearchViewOutput, SearchInteractorOutput, SearchPresenterInput {    
    
    var photos: Variable<[Photo]> = Variable([])
    var searchString: Variable<String> = Variable("")
    
    weak var view: SearchViewInput!
    var intractor: SearchInteractorInput!
    var router: SearchRouterInput!
    
     var bag: DisposeBag!
    var searchBag: DisposeBag!
    
    init() {
        self.bag = DisposeBag()
        self.searchBag = DisposeBag()
     }
    
    func viewIsReady() {
        self.searchString.asObservable()
             .filter { !$0.isEmpty }
            .subscribe(onNext: { (nextString) in
            self.searchChange(searchString: nextString)
        }).disposed(by: self.bag)
    }
    
    
    func searchChange(searchString: String) {
        self.searchBag = DisposeBag()
        self.view.showLoader()
        let observable = self.intractor.getFlickerData(search: searchString, pageNumber: 1, pageSize: 10).subscribe(onNext: { (response) in
            self.view.hideLoader()
            if let photos = response.photos?.photo {
                self.photos.value = photos
            } else {
                print("show error")
            }
        }, onError: { (error) in
            print(error)
            print("show error")
        }, onCompleted: {
            print("operation completed")
        }) {
            print("operation desposed")
        }
        observable.disposed(by: searchBag)
    }
    
    func pushOnDetail(photo: Photo) {
        self.router.pushDetailViewController(photo: photo)
    }
    
    deinit {
        self.bag = nil
        self.searchBag = nil
    }
    
}
