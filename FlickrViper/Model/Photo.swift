//
//  Photo.swift
//  VIPERFlickar
//
//  Created by Abhishek Tripathi on 04/07/18.
//  Copyright © 2018 Abhishek Tripathi. All rights reserved.
//

import Foundation
 import ObjectMapper



class PhotosRespose: Mappable {
    var stat: String = ""
    var photos: Photos?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        stat             <- map["stat"]
        photos       <- map["photos"]
    }
}

class Photos: Mappable {
    
    var page: Int = -1
    var total: String = ""
    var photo: [Photo] = [Photo]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        page             <- map["page"]
        total       <- map["total"]
        photo        <- map["photo"]
    }
}

class Photo: Mappable {
    
    var id: String = ""
    var owner: String = ""
    var secret: String = ""
    var server: String = ""
    var farm: Int = -1
    var title: String = ""
    var ispublic: Int?
    var isfriend: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id             <- map["id"]
        owner       <- map["owner"]
        secret        <- map["secret"]
        server             <- map["server"]
        farm       <- map["farm"]
        title        <- map["title"]
        ispublic             <- map["ispublic"]
        isfriend       <- map["isfriend"]
    }
    
    func flickrImageURL(_ size:String = "m") -> URL? {
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg") {
            return url
        }
        return nil
    }
}
