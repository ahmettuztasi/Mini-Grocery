//
//  HTTPMethod.swift
//  Mini Grocery
//
//  Created by ahmet on 12.12.2020.
//

import Foundation

/// This enum contains http method. It gives method that string type when it's called.
/// Usage Example: HttpMethod.get
public enum HttpMethod: String{
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}
