//
//  JsonManager.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation
import Sealion

class JsonManager {
    
    private let json: JSON
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(jsonNamed: String) {
        let fileURL  = Bundle(for: JsonManager.self).url(forResource: jsonNamed, withExtension: "json")!
        let fileData = try! Data(contentsOf: fileURL)
        self.json    = try! JSONSerialization.jsonObject(with: fileData, options: []) as! JSON
    }
    
    // ----------------------------------
    //  MARK: - Getters -
    //
    func modelJsonFor(key: String) -> JSON {
        var json = self.json[key] as! JSON
        for (key, value) in json {
            
            if let string = value as? String,
                string.hasPrefix("###") {
                
                let index = string.index(string.startIndex, offsetBy: 3)
                let alias = string.substring(from: index)
                
                json[key] = self.json[alias]
            }
        }
        return json
    }
}
