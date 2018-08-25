//
//  SearchFactory.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import UIKit

class SearchFactory {
    // dependencyInjection
    func getResolver() -> SearchRouter {
      
        let viewController = getMainStroyBoard().instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        let presnter = SearchPresenter()
        let intreactor = SearchInteractor()
        let router = SearchRouter()
        
        viewController.output = presnter
        
        presnter.view = viewController
        presnter.intractor = intreactor
        presnter.router = router
        
        intreactor.output = presnter
        intreactor.networkService = NetoworkServiceImpl()
                
        router.viewController = viewController
        
        return router
    }
}


 func getMainStroyBoard() -> UIStoryboard{
    return UIStoryboard(name: "Main", bundle: nil)
}
