//
//  SearchViewCell.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(data: Photo) {
        self.name.text = data.title
        if let url = data.flickrImageURL() {
            self.imageViewCell.af_setImage(withURL: url, placeholderImage: UIImage(named: "errorExclamation"))
        }
    }
    
    

}
