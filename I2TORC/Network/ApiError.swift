//
//  ApiError.swift
//  Namava
//
//  Created by Shayan Amin on 10/16/19.
//  Copyright © 2019 Namava. All rights reserved.
//

import Foundation

enum ApiError: Int {
    case forbidden           = 403 //Status code 403
    case notFound            = 404 //Status code 404
    case conflict            = 409 //Status code 409
    case unAuthorize         = 401 //Status code 401
    case internalServerError = 500 //Status code 500
    case requestTimeOut      = -1001 //Status code -1001
    case requestExceeded     = 429  //Status code 429
    case profileNotFound     = 20504 //Status code 20504
}


