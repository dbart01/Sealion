//
//  APITestCase.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
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
    func assertHeaders(_ handle: Handle) {
        let request = handle.originalRequest!
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer token")
        
        if request.httpMethod == "POST" {
            XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
        }
    }
    
    func assertBody(_ handle: Handle, data: Data?) {
        XCTAssertEqual(handle.originalRequest!.httpBody, data)
    }
    
    func assertBody<T: JsonConvertible>(_ handle: Handle, object: T) {
        let data = try! JSONSerialization.data(withJSONObject: object.json, options: [])
        self.assertBody(handle, data: data)
    }
    
    func assertMethod(_ handle: Handle, method: Sealion.Method) {
        XCTAssertEqual(handle.originalRequest!.httpMethod, method.rawValue)
    }
    
    func assertEndpoint(_ handle: Handle, endpoint: Endpoint) {
        XCTAssertEqual(handle.originalRequest!.url!.stripped.absoluteString, "https://api.digitalocean.com/v2/\(endpoint.path)")
    }
    
    func assertKeyPath(_ handle: Handle, keyPath: String?) {
        XCTAssertEqual(handle.keyPath, keyPath)
    }
    
    func assertParameters(_ handle: Handle, parameters: ParameterConvertible) {
        let components = URLComponents(url: handle.originalRequest!.url!, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems!
        
        let parameterItems = parameters.parameters
        XCTAssertEqual(queryItems.count, parameterItems.count)
        
        for item in queryItems {
            XCTAssertEqual(parameterItems[item.name], item.value)
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
