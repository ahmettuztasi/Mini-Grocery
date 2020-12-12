//
//  HttpLink.swift
//  Mini Grocery
//
//  Created by ahmet on 12.12.2020.
//

import Foundation

/// This enum providing all service connection links.
/// - Usage Example: HttpLink.photos.value
/// - Returns: a string type of link
public enum HttpLink: String {
    /// mainURL is most important case of this enum because it stored main link.
    case mainURL = "https://desolate-shelf-18786.herokuapp.com/"
    
    case list = "list"
    case checkout = "checkout"
    
    /// this variable returning full link when it is get called
    var UrlValue: String {
        return HttpLink.mainURL.rawValue + self.rawValue
    }
}
