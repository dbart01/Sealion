//
//  APITestCase.swift
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

import XCTest
@testable import Sealion

class APITestCase: XCTestCase {
    
    lazy private(set) var api: API = {
        return API(version: .v2, token: "token")
    }()
    
    // ----------------------------------
    //  MARK: - Assertions -
    //
    func assertType<T>(_ handle: Handle<T>, type: T.Type) {
        XCTAssertTrue(true)
    }
    
    func assertType<T, U>(_ handle: Handle<T>, type: U.Type) {
        XCTFail("Type \(T.self) doesn't match type: \(type)")
    }
    
    func assertHeaders<T>(_ handle: Handle<T>) {
        let request = handle.originalRequest!
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer token")
        
        if request.httpMethod == "POST" {
            XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        }
    }
    
    func assertBody<T>(_ handle: Handle<T>, data: Data?) {
        XCTAssertEqual(handle.originalRequest!.httpBody, data)
    }
    
    func assertBody<T, U: JsonConvertible>(_ handle: Handle<T>, object: U) {
        let data = try! JSONSerialization.data(withJSONObject: object.json, options: [])
        self.assertBody(handle, data: data)
    }
    
    func assertMethod<T>(_ handle: Handle<T>, method: Sealion.Method) {
        XCTAssertEqual(handle.originalRequest!.httpMethod, method.rawValue)
    }
    
    func assertEndpoint<T>(_ handle: Handle<T>, endpoint: Endpoint) {
        XCTAssertEqual(handle.originalRequest!.url!.stripped.absoluteString, "https://api.digitalocean.com/v2/\(endpoint.path)")
    }
    
    func assertKeyPath<T>(_ handle: Handle<T>, keyPath: String?) {
        XCTAssertEqual(handle.keyPath, keyPath)
    }
    
    func assertParameters<T>(_ handle: Handle<T>, parameters: ParameterConvertible?) {
        let components = URLComponents(url: handle.originalRequest!.url!, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems
        
        let parameterItems = parameters?.parameters
        XCTAssertEqual(queryItems?.count ?? 0, parameterItems?.count ?? 0)
        
        if let queryItems = queryItems {
            for item in queryItems {
                XCTAssertEqual(parameterItems![item.name], item.value)
            }
        }
    }
}

extension URL {
    
    var stripped: URL {
        var components        = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        components.queryItems = nil
        components.fragment   = nil
        return components.url!
    }
}
