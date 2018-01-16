//
//  Response.swift
//  GenericAPI
//
//  Created by appsistemas on 29/12/17.
//  Copyright © 2017 appsistemas. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JsonDecodable {
    
    init?(decode: JSON)
    
}

struct Response {
    
    let status: String
    let code: Int
    var message: String?
    let payload: JSON
    
    var succeeded: Bool {
        return code == 200
    }
    
    init?(data: Data)  {
        
        let json         = JSON(data)
        
        guard let status = json["status"].string,
        let code         = json["code"].int else {
            return nil
        }
        self.code        = code
        self.status      = status
        self.payload     = json["result"]
    }



}
