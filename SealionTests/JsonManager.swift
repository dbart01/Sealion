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
    
    private var originalJson: JSON!
    private var expandedJson: JSON!
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(jsonNamed: String) {
        let result        = JsonManager.preprocessJsonNamed(jsonNamed)
        self.originalJson = result.original
        self.expandedJson = result.processed
    }
    
    // ----------------------------------
    //  MARK: - Getters -
    //
    func modelJsonFor(key: String, expandAliases: Bool = true) -> JSON {
        if expandAliases {
            return self.expandedJson[key] as! JSON
        } else {
            return self.originalJson[key] as! JSON
        }
    }
    
    // ----------------------------------
    //  MARK: - Preprocessing Json -
    //
    static func preprocessJsonNamed(_ jsonNamed: String) -> (original: JSON, processed: JSON) {
        let fileURL    = Bundle(for: JsonManager.self).url(forResource: jsonNamed, withExtension: "json")!
        let fileData   = try! Data(contentsOf: fileURL)
        var fileString = String(data: fileData, encoding: .utf8)! as NSString
        let original   = try! JSONSerialization.jsonObject(with: fileData, options: []) as! JSON
        
        let regex   = try! NSRegularExpression(pattern: "\"###(.+?)\"", options: [])
        let results = regex.matches(in: fileString as String, options: [], range: NSRange(location: 0, length: fileString.length))
        
        for result in results.reversed() {
            guard result.numberOfRanges > 1 else {
                continue
            }
            
            let range  = result.rangeAt(1)
            let alias  = fileString.substring(with: range)
            
            guard let object = original[alias] else {
                fatalError("Alias not found: \(alias)")
            }
            
            let data   = try! JSONSerialization.data(withJSONObject: object, options: [])
            let string = String(data: data, encoding: .utf8)!
            
            let replacementRange = result.rangeAt(0)
            fileString = fileString.replacingCharacters(in: replacementRange, with: string) as NSString
        }
        
        let processedData = (fileString as String).data(using: .utf8)
        let processed     = try! JSONSerialization.jsonObject(with: processedData!, options: []) as! JSON
        
        return (original, processed)
    }
}
