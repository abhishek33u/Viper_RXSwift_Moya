//
//  SearchInteractor.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class SearchInteractor: SearchInteractorInput {
     
    
    weak var output: SearchInteractorOutput!
    
    var networkService: NetoworkService!
    func getFlickerData(search: String, pageNumber: Int, pageSize: Int) -> Observable<PhotosRespose> {
        let obsevable: Observable<PhotosRespose> =  networkService.callRxServicse(target: VIPERFlickarTarget.getlist(searchString: search, pageSize: pageSize, pageNumber: pageNumber), objectType: PhotosRespose.self)
        return obsevable
    }
    
}
