////
////  ApiRouter.swift
////  I2TORC
////
////  Created by sadegh bardouei on 6/4/23.
////
//
//import Foundation
//import Alamofire
//
//enum ApiRouter: URLRequestConvertible {
//    
//    //Get
//    case configurations
//    
//    //MARK: - Parameters
//    //This is the queries part, it's optional because an endpoint can be without parameters
//    private var parameters: Parameters? {
//        switch self {
//        case .configurations:
//            return nil
//        }
//    }
//    
//    //MARK: - HttpMethod
//    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
//    private var method: HTTPMethod {
//        switch self {
//        case .configurations:
//            return .post
//        }
//    }
//    
//    //MARK: - Path
//    //The path is the part following the base url
//    private var path: String {
//        switch self {
//        case .configurations:
//            return NetworkConstants.apiVersion + "auth/register"
//        }
//    }
//    
//    //    //MARK: - Headers
//    //    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
//    //    private var headers: HTTPHeaders? {
//    //        let header: HTTPHeaders?
//    //
//    //        header = ["x-auth-token": General.userToken]
//    //
//    //        switch self {
//    //        case .configurations:
//    //            return header
//    //        }
//    //    }
//    
//    func asURLRequest() throws -> URLRequest {
//        let url = try NetworkConstants.baseUrl.asURL()
//        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
//        
//        //Http method
//        urlRequest.httpMethod = method.rawValue
//        // Common Headers
//        urlRequest.setValue(NetworkConstants.ContentType.xApplicationType.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.xApplicationType.rawValue)
//        
//        urlRequest.setValue(NetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.contentType.rawValue)
//        
//        //            if headers != nil {
//        //                headers?.forEach { header in
//        //                    urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
//        //                }
//        //            }
//        
//        
//        //            //Request Body
//        //            switch self {
//        //            case .coldStartMediaIds(let mediaIds):
//        //                urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: mediaIds)
//        //            default:
//        //                break
//        //            }
//        
//        //Encoding
//        let encoding: ParameterEncoding = {
//            
//            switch method {
//            case .get:
//                return URLEncoding.init(boolEncoding: .literal)
//                
//            case .post:
//                return JSONEncoding.default
//                
//            case .delete:
//                return JSONEncoding.default
//                
//            default:
//                return JSONEncoding.default
//            }
//        }()
//        
//        return try encoding.encode(urlRequest, with: parameters)
//    }
//}
//extension String: URLConvertible {
//    /// Returns a `URL` if `self` can be used to initialize a `URL` instance, otherwise throws.
//    ///
//    /// - Returns: The `URL` initialized with `self`.
//    /// - Throws:  An `AFError.invalidURL` instance.
//    public func asURL() throws -> URL {
//        guard let url = URL(string: self) else { throw AFError.invalidURL(url: self) }
//        
//        return url
//    }
//}
