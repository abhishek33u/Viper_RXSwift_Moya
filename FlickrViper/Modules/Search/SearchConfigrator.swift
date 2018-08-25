//
//  SearchConfigrator.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation

protocol SearchConfigrator {
    func getRouter() -> SearchRouter
}

class SearchConfigratorImpl: SearchConfigrator {
    func getRouter() -> SearchRouter {
        return SearchFactory().getResolver()
    }
}
