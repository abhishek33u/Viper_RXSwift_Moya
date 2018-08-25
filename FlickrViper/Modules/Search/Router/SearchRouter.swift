//
//  SearchRouter.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
import UIKit

class SearchRouter: SearchRouterInput {
    
    weak var viewController: UIViewController!
    
    func pushDetailViewController(photo: Photo) {
        let router = DetailConfigratorImpl().getRouter(photo: photo)
        self.viewController.navigationController?.pushViewController(router.viewController, animated: true)
    }
}
