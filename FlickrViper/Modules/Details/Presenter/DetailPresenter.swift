//
//  DetailPresenter.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailPresenter: DetailViewOutput, DetailInteractorOutput, DetailPresenterInput {
   
    var photo: Photo!
    
    weak var view: DetailViewInput!
    var intractor: DetailInteractorInput!
    var router: DetailRouterInput!
    
    
     var bag:DisposeBag! = DisposeBag()
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    func viewIsReady() {
        self.view.showDetailView(photo: self.photo)
    }
    
    deinit {
        self.bag = nil
    }
}
