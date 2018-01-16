//
//  ServiceAPI.swift
//  GenericAPI
//
//  Created by appsistemas on 28/12/17.
//  Copyright © 2017 appsistemas. All rights reserved.
//

import Foundation
import Moya

enum ServiceAPI {
    
    case zen
    
}

extension ServiceAPI: TargetType {
    
    
    var baseURL: URL {
        return URL(string: "http://www.mocky.io")!
    }
    
    var sampleData: Data {
        switch self {
        case .zen:
            return Data()
        }
    }
    
    public var path: String {
        switch self {
        case .zen:
            return "/v2/5a462e132e00007f08ae9155"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .zen:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .zen:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
    

        
}





