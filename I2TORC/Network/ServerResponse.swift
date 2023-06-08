//
//  ServerResponse.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import Foundation

final class ArrayResponse<T: Codable>: Codable {
//    var succeeded: Bool?
//    var result: [T]?
    var error: BusinessLogicError?
    var success: Bool?
    var data: [T]?
}

final class ObjectResponse<T: Codable>: Codable {
//    var succeeded: Bool?
//    var result: T?
    var error: BusinessLogicError?
    var success: Bool?
    var data: T?
}

final class BusinessLogicError: Codable {
    var code: Int?
    var message: String?
    var details: String?
    
    init() {}
    init(code: Int?, message: String?, detail: String? = "") {
        self.code    = code
        self.details = detail
        if let code = code {
//           self.message = getBusinessErrorMessage(code: code)
            self.message = message
            
        } else {
            self.message = message
        }
        
    }
}

final class ServerError: Error {
    var statusCode: Int?
    var message: String?
}

final class SearchObjectResponse<T: Codable>: Codable {
    var succeeded: Bool?
    var result: SearchResponse<T>?
    var error: BusinessLogicError?
}

final class SearchResponse<T: Codable>: Codable {
    var total: Int?
    var page: Int?
    var resultItems: [T]?
    var isSucceed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case total, page
        case resultItems = "result_items"
        case isSucceed = "is_succeed"
    }
}



