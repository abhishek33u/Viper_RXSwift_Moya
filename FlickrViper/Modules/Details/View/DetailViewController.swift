//
//  DetailViewController.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import AlamofireImage

class DetailViewController: UIViewController, DetailViewInput {

    var output: DetailViewOutput!
    
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var bag:DisposeBag? = DisposeBag()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.output.viewIsReady()
       
    }
    
    func showDetailView(photo: Photo) {
        self.titleLabel.text = photo.title
        if let url = photo.flickrImageURL("c") {
            self.imageView.af_setImage(withURL: url, placeholderImage: UIImage(named: "errorExclamation"))
        }
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.bag = nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

 
