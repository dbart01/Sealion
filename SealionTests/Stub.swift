//
//  Stub.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation
import Sealion

struct Stub {
    
    let status:  Int
    let json:    JSON?
    let error:   String?
    let headers: [String : String]?
    
    var jsonData: Data? {
        if let json = self.json {
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        }
        return nil
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(json: [String : Any]) {
        self.status  = json["status"]  as! Int
        self.json    = json["json"]    as? JSON
        self.error   = json["error"]   as? String
        self.headers = json["headers"] as? [String : String]
    }
    
    init(status: Int, json: JSON? = nil, error: String? = nil, headers: [String : String]? = nil) {
        self.status  = status
        self.json    = json
        self.error   = error
        self.headers = headers
    }
}
