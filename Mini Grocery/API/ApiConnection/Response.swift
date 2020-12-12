//
//  Response.swift
//  Mini Grocery
//
//  Created by ahmet on 12.12.2020.
//

import Foundation

/// this enum used for return data or error when get response from service. It used in closure(callback)
/// - success returning value
/// - failure returning error
public enum Response<Value> {
    case success(Value)
    case failure(Error)
}
