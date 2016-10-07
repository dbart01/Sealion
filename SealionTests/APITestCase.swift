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
    func assertToken(_ handle: Handle) {
        XCTAssertEqual(handle.originalRequest!.value(forHTTPHeaderField: "Authorization"), "Bearer token")
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
    
    func assertParameters(_ handle: Handle, parameters: API.Parameters) {
        let components = URLComponents(url: handle.originalRequest!.url!, resolvingAgainstBaseURL: false)!
        let queryItems = components.queryItems!
        
        XCTAssertEqual(queryItems.count, parameters.count)
        
        for item in queryItems {
            XCTAssertEqual(parameters[item.name], item.value)
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
