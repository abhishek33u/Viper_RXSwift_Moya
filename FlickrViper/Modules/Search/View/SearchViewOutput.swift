//
//  SearchViewOutput.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol SearchViewOutput {
    func viewIsReady() 
    func pushOnDetail(photo: Photo)
    var photos: Variable<[Photo]>{get}
    var searchString: Variable<String>{get}
 }
