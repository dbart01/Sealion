//
//  API+RecordTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_RecordTests: APITestCase {
    
    func testRecordList() {
        let domain = "example.com"
        let handle = self.api.recordsFor(domain: domain) { result in }
        
        self.assertType(handle, type: [Record].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .recordsForDomain(domain))
        self.assertKeyPath(handle, keyPath: "domain_records")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testRecordWithID() {
        let domain = "example.com"
        let id     = 123
        let handle = self.api.recordFor(domain: domain, id: id) { result in }
        
        self.assertType(handle, type: Record.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .recordForDomain(domain, id))
        self.assertKeyPath(handle, keyPath: "domain_record")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testRecordCreate() {
        let request = Record.CreateRequest(kind: .a, name: "@", value: "12.12.12.12")
        let domain  = "example.com"
        let handle  = self.api.create(record: request, domain: domain) { result in }
        
        self.assertType(handle, type: Record.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .recordsForDomain(domain))
        self.assertKeyPath(handle, keyPath: "domain_record")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testRecordUpdate() {
        let request = Record.UpdateRequest(name: "mail")
        let domain  = "example.com"
        let record  = 123
        let handle  = self.api.update(record: record, request: request, domain: domain) { result in }
        
        self.assertType(handle, type: Record.self)
        self.assertMethod(handle, method: .put)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .recordForDomain(domain, record))
        self.assertKeyPath(handle, keyPath: "domain_record")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testDomainDelete() {
        let domain = "example.com"
        let record = 123
        let handle = self.api.delete(record: record, domain: domain) { result in }
        
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .recordForDomain(domain, record))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
}
