//
//  DetailFactory.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import UIKit

class DetailFactory {
    // dependencyInjection
    func getResolver(photo: Photo) -> DetailRouter {
      
        let viewController = getMainStroyBoard().instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        
        let presnter = DetailPresenter(photo: photo)
        let intreactor = DetailInteractor()
        let router = DetailRouter()
        
        viewController.output = presnter
        
        intreactor.output = presnter
        intreactor.networkService = NetoworkServiceImpl()
        
        presnter.view = viewController
        presnter.intractor = intreactor
        presnter.router = router
        
        router.viewController = viewController
        
        return router
    }
    
    
    
    
}

 
