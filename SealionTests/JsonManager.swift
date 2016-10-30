//
//  JsonManager.swift
//  Sealion
//
//  Copyright (c) 2016 Dima Bart
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
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
        let original   = try! JSONSerialization.jsonObject(with: fileData, options: []) as! JSON
        
        let regex      = try! NSRegularExpression(pattern: "\"###(.+?)\"", options: [])
        var results    = [NSTextCheckingResult]()
        var fileString = String(data: fileData, encoding: .utf8)! as NSString
        
        /* ----------------------------------
         ** Repeat regex matching until there
         ** are no more matches left. This is
         ** necessary for nested objects with
         ** references. Otherwise, not all 
         ** references will be replaced.
         */
        repeat {
            
            results = regex.matches(in: fileString as String, options: [], range: NSRange(location: 0, length: fileString.length))
            
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
            
        } while results.count > 0
        
        let processedData = (fileString as String).data(using: .utf8)
        let processed     = try! JSONSerialization.jsonObject(with: processedData!, options: []) as! JSON
        
        return (original, processed)
    }
}
