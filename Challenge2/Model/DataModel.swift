//
//  DataModel.swift
//  Challenge2
//
//  Created by ajaykumar on 26/08/21.
//

import Foundation
struct UserData: Codable {
    
    var itemType: String
    
    var data: String
    
    var userName: String
    
    var thumbnail: String
    
    var profilePic: String
    
    var comment: String

    
    
    enum CodingKeys : String, CodingKey {
        case itemType = "item_type"
        
        case data = "data"
        
        case userName = "userName"
        
        case thumbnail = "thumbnail"
        
        case profilePic = "profilePic"
        
        case comment = "comment"
        

    }

}

struct ContentType {
    
    static let Image = "Image"
    
    static let Video = "Video"
    
    static let Text = "Text"
    
    static let WebView = "WebView"

}
