//
//  APIManager.swift
//  Mini Grocery
//
//  Created by ahmet on 12.12.2020.
//

import Foundation
import Alamofire

/// This Connection Manager class responsible for comminicate to service.
/// - Parameters: Url, send model, header, http method
/// - Note: This class using builder pattern. Service words means in this class is API which is send and get data
final class APIManager {
    ///this dictionary going to get parameters when it's called and store all parameters for sendRequest method.
    fileprivate var requestDict: [String:Any] = [:]
    
    ///this method get url which is app needs to connect service
    /// - Parameters: Url -> String type
    /// - Returns: self which means Connection Manager class
    func setBaseUrl(url: String) -> APIManager {
        requestDict.updateValue(url, forKey: "url")
        return self
    }
    ///this method get http method which is according to process with service
    /// - Parameters: method -> enum (generally it is string type)
    /// - Returns: self which means Connection Manager class
    func setMethod(method: HTTPMethod ) -> APIManager {
        requestDict.updateValue(method, forKey: "method")
        return self
    }
    /// this method get http body parameters which is need to send service
    /// - Parameters: body parameters -> dictionary type
    /// - Returns: self which means Connection Manager class
    func setParameters(parameters: Parameters) -> APIManager {
        requestDict.updateValue(parameters, forKey: "parameters")
        return self
    }
    ///this method send request to service using Alamofire framework and return a result
    /// - Parameters: url, http method, http body parameters, http header,
    /// - Returns: if connection is success, it's returning Data, else it's returning an Error.
    func sendRequest(completion: @escaping (Response<Data>) -> Void) {
        AF.request(requestDict["url"] as! String,
                method: requestDict["method"] as! HTTPMethod,
                parameters: requestDict["parameters"] as? Parameters,
                encoding: JSONEncoding.default).responseData { (response) in
                    switch response.result {
                    case .success(let data): completion(.success(data))
                    case .failure(let error): completion(.failure(error))
                    }
        }
    }
}
