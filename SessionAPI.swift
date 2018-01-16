//
//  SessionAPI.swift
//  GenericAPI
//
//  Created by appsistemas on 28/12/17.
//  Copyright © 2017 appsistemas. All rights reserved.
//

import Foundation
import Moya
import RxSwift


enum ErrorSessionAPI: Error {
    case errorNotDecodeJson
    case errorContentPayload(code: Int, message: String)
}

final class SessionAPI {

    let provider = MoyaProvider<ServiceAPI>()
    
    // MARK: - API Private
   private func data(service: ServiceAPI) -> Observable<Data> {
        return Observable<Data>.create { observer -> Disposable in
            let task = self.provider.request(service, completion: { result in
                switch result {
                case .success(let dat):
                    observer.onNext(dat.data)
                    observer.onCompleted()
                case .failure(let err):
                    observer.onError(err)
                }
                
            })
            
            return Disposables.create {
                //Cancel request
                print("Cancel request")
                task.cancel()
            }
        }
        
    }
    
    private func response(service: ServiceAPI) -> Observable<Response> {
        
        return data(service: service).map{ data  in
            guard let response = Response(data: data) else {
                //control the parsing error of the response data
                throw ErrorSessionAPI.errorNotDecodeJson
            }
            guard response.succeeded else {
                //Control the error content response
                throw ErrorSessionAPI.errorContentPayload(code: response.code, message: response.message ?? "")
            }
            return response
        }
        
    }
    
    func object<T: JsonDecodable> (service: ServiceAPI) -> Observable<T>  {
        return response(service: service).map({ response in
            guard let  object: T = T(decode: response.payload) else {
                throw ErrorSessionAPI.errorNotDecodeJson
            }
            
            return object
        })
       
    }
    func objects<T: JsonDecodable> (service: ServiceAPI) -> Observable<T>  {
        return response(service: service).map({ response in
            guard let  object: T = T(decode: response.payload)  else {
                throw ErrorSessionAPI.errorNotDecodeJson
            }
            
            return object
        })
        
    }
    
    //MARK: - API public
    func result (service: ServiceAPI) -> Observable<Result> {
        
        return object(service: service)
        
        
    }
    func results (service: ServiceAPI) -> Observable<Results> {
        
        return objects(service: service)
        
        
    }
    
    
    
    
}






