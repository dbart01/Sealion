//
//  API+DomainTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_DomainTests: APITestCase {
    
    func testDomainsList() {
        
        let handle  = self.api.domains { result in }
        
        self.assertType(handle, type: [Domain].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .domains)
        self.assertKeyPath(handle, keyPath: "domains")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testDomainWithName() {
        let name   = "example.com"
        let handle = self.api.domainWith(name: name) { result in }
        
        self.assertType(handle, type: Domain.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .domainWithName(name))
        self.assertKeyPath(handle, keyPath: "domain")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testDomainCreate() {
        let request = Domain.CreateRequest(ip: "12.12.12.12", name: "example.com")
        let handle  = self.api.create(domain: request) { result in }
        
        self.assertType(handle, type: Domain.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .domains)
        self.assertKeyPath(handle, keyPath: "domain")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testDomainDelete() {
        let name   = "example.com"
        let handle = self.api.delete(domain: name) { result in }
        
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .domainWithName(name))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
}
