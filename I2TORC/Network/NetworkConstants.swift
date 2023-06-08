//
//  NetworkConstants.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import Foundation

struct NetworkConstants {
    
    enum RouteType : String, CaseIterable {
        case baseTestUrl   = "http://170.130.165.71:3000"
        case apiVerion = "v1.0/"
    }
    
    enum HttpHeaderField: String {
        case authentication   = "Authorization"
        case contentType      = "Content-Type"
        case acceptType       = "Accept"
        case xApplicationType = "x-application-type"
        case acceptEncoding   = "Accept-Encoding"
        case xStoreType       = "x-store-type"
        case userAgent        = "User-Agent"
        case profileId        = "x-profile-id"
    }
    
    enum ContentType: String {
        case json             = "application/json"
        case xApplicationType = "IOSClient"
    }
    
    //The parameters (Queries) that we're gonna use
    struct Parameters {
        static let userId = "userId"
    }
    
    static let baseUrl: String = RouteType.baseTestUrl.rawValue
//    RouteType.baseMainUrl.rawValue
    static let apiVersion: String  = RouteType.apiVerion.rawValue
    
}

