//
//  SearchInteractorInput.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
 

protocol SearchInteractorInput: class {
     func getFlickerData(search: String, pageNumber: Int, pageSize: Int)  -> Observable<PhotosRespose>
}
