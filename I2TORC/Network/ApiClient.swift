//
//  ApiClient.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import Foundation
import RxSwift
import Alamofire

final class ApiClient {
    
    static let sharedInstance = ApiClient()
    
    private init() {}
    
    
    
    //MARK: - The request function to get results in an Observable
    func requestArray<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<ArrayResponse<T>> {
        
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<ArrayResponse<T>>.create { observer in
            
            
            let request = AF.request(urlConvertible)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: ArrayResponse<T>.self) { response in
                    
                    //Check the result from Alamofire's response and check if it's a success or a failure
                    switch response.result {
                    case .success(let value):
                        //Everything is fine, return the value in onNext
                        let errorType: ApiError? = ApiError(rawValue: value.error?.code ?? -1)
                        if errorType == .profileNotFound {
//                            NotificationCenter.default.post(name: General.ERROR_ProfileNotFound_HAPPENED, object: nil)
                        } else {
                            observer.onNext(value)
                            observer.onCompleted()
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        //Something went wrong, switch on the status code and return the error
                        
                        let serverError = ServerError()
                        serverError.statusCode = response.response?.statusCode
                        
                        let errorType: ApiError? = ApiError(rawValue: response.response?.statusCode ?? -1)
                        
                        switch errorType {
                        case .forbidden:
//                            serverError.message = ApiErrorMessage.forbidden
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_403_HAPPENED, object: nil)
                            
                        case .notFound:
//                            serverError.message = ApiErrorMessage.notFound
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_404_HAPPENED, object: nil)
                            
                        case .conflict:
//                            serverError.message = ApiErrorMessage.conflict
                            observer.onError(serverError)
                            
                        case .internalServerError:
//                            serverError.message = ApiErrorMessage.internalServerError
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_500_HAPPENED, object: nil)
                            
                        case .unAuthorize:
//                            serverError.message = ApiErrorMessage.unAuthorize
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_401_HAPPENED, object: nil)
                            
                        case .requestTimeOut:
//                            serverError.message = ApiErrorMessage.requestTimeOut
                            observer.onError(serverError)
                            
                            
                        default:
                            observer.onError(error)
                        }
                    }
                    
            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {

                request.cancel()
            }
        }.retry(3) { error -> Observable<Void> in
            if error.asAFError?.responseCode == -1001 {
                return Observable.just(())
            }
            
            return Observable.error(error)
        }
    }
    
    //MARK: - The request function to get results in an Observable
    func requestObject<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<ObjectResponse<T>> {
        
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<ObjectResponse<T>>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
            let request = AF.request(urlConvertible)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: ObjectResponse<T>.self) { response in
                    //Check the result from Alamofire's response and check if it's a success or a failure
                    switch response.result {
                    case .success(let value):
                        //Everything is fine, return the value in onNext
                        let errorType: ApiError? = ApiError(rawValue: value.error?.code ?? -1)
                        if errorType == .profileNotFound {
//                            NotificationCenter.default.post(name: General.ERROR_ProfileNotFound_HAPPENED, object: nil)
                        } else {
                            observer.onNext(value)
                            observer.onCompleted()
                        }
                        
                    case .failure(let error):
                        //Something went wrong, switch on the status code and return the error
                        let serverError = ServerError()
                        serverError.statusCode = response.response?.statusCode
                        
                        let errorType: ApiError? = ApiError(rawValue: response.response?.statusCode ?? -1)
                        switch errorType {
                        case .forbidden:
                            serverError.message = "403 happened"
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_403_HAPPENED, object: nil)
                        case .notFound:
                            serverError.message = "404 happened"
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_404_HAPPENED, object: nil)
                        case .conflict:
                            serverError.message = "409 happened"
                            observer.onError(serverError)
                            
                        case .internalServerError:
                            serverError.message = "500 happened"
//                            if ((observer as? RxSwift.AnyObserver<ObjectResponse<ForceUpdateObject>>) != nil) {
//                                observer.onError(serverError)
//                            } else {
                                observer.onError(serverError)
//                                NotificationCenter.default.post(name: General.ERROR_500_HAPPENED, object: nil)
//                            }

                        case .unAuthorize:
                            serverError.message = "401 happened"
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_401_HAPPENED, object: nil)
                            
                        case .requestTimeOut:
                            serverError.message = "request time out happened"
                            observer.onError(serverError)
                            
                        case .requestExceeded:
//                            serverError.message = getServerErrorMessage(code: serverError.statusCode ?? 0)
                            observer.onError(serverError)
                            
                        default:
                            observer.onError(error)
                        }
                    }
            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
                NotificationCenter.default.removeObserver(self)
            }
        }.retry(3) { error -> Observable<Void> in
            if error.asAFError?.responseCode == -1001 {
                return Observable.just(())
            }
            
//            if error.asAFError?.responseCode == 500 {
//                return Observable.just(())
//            }
            
            return Observable.error(error)
        }
    }
    
    
    //MARK: - The request function to get results XML Ad in an Observable
    func requestEvent(_ url: URL) -> Observable<String> {
        
        return Observable<String>.create { observer in
            
            AF.request(url, method: .get){ $0.timeoutInterval = 12 }.response { response in
                switch response.result {
                case .success(let data):
                    observer.onNext("\(String(describing: data))")
                    observer.onCompleted()
                    
                case .failure(let failer):
                    observer.onError(failer)
                }
            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                NotificationCenter.default.removeObserver(self)
            }
        }.retry(3) { error -> Observable<Void> in
            if error.asAFError?.responseCode == -1001 {
                return Observable.just(())
            }
            return Observable.error(error)
        }
    }
    
    func searchRequest<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<SearchObjectResponse<T>> {
        
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<SearchObjectResponse<T>>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
            let request = AF.request(urlConvertible)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: SearchObjectResponse<T>.self) { response in
                    //Check the result from Alamofire's response and check if it's a success or a failure
                    switch response.result {
                    case .success(let value):
                        //Everything is fine, return the value in onNext
                        let errorType: ApiError? = ApiError(rawValue: value.error?.code ?? -1)
                        if errorType == .profileNotFound {
//                            NotificationCenter.default.post(name: General.ERROR_ProfileNotFound_HAPPENED, object: nil)
                        } else {
                            observer.onNext(value)
                            observer.onCompleted()
                        }
                        
                    case .failure(let error):
                        //Something went wrong, switch on the status code and return the error
                        let serverError = ServerError()
                        serverError.statusCode = response.response?.statusCode
                        
                        let errorType: ApiError? = ApiError(rawValue: response.response?.statusCode ?? -1)
                        switch errorType {
                        case .forbidden:
                            serverError.message = "403 happened"
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_403_HAPPENED, object: nil)
                            
                        case .notFound:
                            serverError.message = "404 happened"
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_404_HAPPENED, object: nil)
                            
                        case .conflict:
                            serverError.message = "409 happened"
                            observer.onError(serverError)
                            
                        case .internalServerError:
                            serverError.message = "500 happened"
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_500_HAPPENED, object: nil)
                            
                        case .unAuthorize:
                            serverError.message = "401 happened"
                            observer.onError(serverError)
//                            NotificationCenter.default.post(name: General.ERROR_401_HAPPENED, object: nil)
                            
                            
                        case .requestTimeOut:
                            serverError.message = "request time out happened"
                            observer.onError(serverError)
                            
                        default:
                            observer.onError(error)
                        }
                    }
                }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
                NotificationCenter.default.removeObserver(self)
            }
        }.retry(3) { error -> Observable<Void> in
            if error.asAFError?.responseCode == -1001 {
                return Observable.just(())
            }
            
//            if error.asAFError?.responseCode == 500 {
//                return Observable.just(())
//            }
            
            return Observable.error(error)
        }
    }
    
}

extension ObservableType {
    func retry(_ maxAttemptCount: Int = 1, when: @escaping (Error) -> Observable<Void>) -> Observable<Element> {
        return retry { errorObservable -> Observable<Void> in
            var retries = maxAttemptCount
            return errorObservable.flatMap { error -> Observable<Void> in
                guard retries > 0 else { return Observable.error(error) }
                retries -= 1
                return when(error)
            }
        }
    }
}


extension URLResponse {
    func headerField(forKey key: String) -> String? {
        (self as? HTTPURLResponse)?.allHeaderFields[key] as? String
    }
}

