//
//  Stub.swift
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

// ----------------------------------
//  MARK: - Error Json -
//
struct MockError {
    
    let code:        Int
    let domain:      String
    let description: String
    
    init(domain: String = "MockErrorDomain", code: Int, description: String = "No description") {
        self.code        = code
        self.domain      = domain
        self.description = description
    }
    
    func cocoaError() -> NSError {
        return NSError(domain: self.domain, code: self.code, userInfo: [
            NSLocalizedDescriptionKey : self.description,
        ])
    }
}

// ----------------------------------
//  MARK: - Stub -
//
struct Stub {
    
    let status:  Int?
    let json:    JSON?
    let error:   MockError?
    let headers: [String : String]?
    
    var executionTime = 0.0
    
    var jsonData: Data? {
        if let json = self.json {
            return try? JSONSerialization.data(withJSONObject: json, options: [])
        }
        return nil
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(status: Int? = nil, json: JSON? = nil, error: MockError? = nil, headers: [String : String]? = nil) {
        self.status  = status
        self.json    = json
        self.error   = error
        self.headers = headers
    }
}
