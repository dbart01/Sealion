//
//  RecordTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class RecordTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Record = self.modelNamed(name: "record")
        
        XCTAssertEqual(model.id,       123)
        XCTAssertEqual(model.kind,     Record.Kind(rawValue: "MX")!)
        XCTAssertEqual(model.name,     "@")
        XCTAssertEqual(model.value,    "mail.example.com")
        XCTAssertEqual(model.priority, 1)
        XCTAssertEqual(model.port,     80)
        XCTAssertEqual(model.weight,   10)
    }
    
    func testJsonCreationWithNullValues() {
        let model: Record = self.modelNamed(name: "recordWithNull")
        
        XCTAssertEqual(model.id,       123)
        XCTAssertEqual(model.kind,     Record.Kind(rawValue: "A")!)
        XCTAssertEqual(model.name,     "@")
        XCTAssertEqual(model.value,    "example.com")
        XCTAssertEqual(model.priority, nil)
        XCTAssertEqual(model.port,     nil)
        XCTAssertEqual(model.weight,   nil)
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Record.self, name: "record")
    }
    
    // ----------------------------------
    //  MARK: - Create Request -
    //
    func testCreateRequest() {
        let kind    = Record.Kind.a
        let name    = "@"
        let value   = "12.12.12.12"
        var request = Record.CreateRequest(kind: .a, name: name, value: value)
        
        var json    = request.json
        
        XCTAssertEqual(json["type"] as! String, kind.rawValue)
        XCTAssertEqual(json["name"] as! String, name)
        XCTAssertEqual(json["data"] as! String, value)
        
        XCTAssertNil(json["priority"])
        XCTAssertNil(json["port"])
        XCTAssertNil(json["weight"])
        
        let priority     = 10
        request.priority = priority
        json = request.json
        XCTAssertEqual(json["priority"] as! Int, priority)
        
        let port     = 80
        request.port = port
        json = request.json
        XCTAssertEqual(json["port"] as! Int, port)
        
        let weight     = 5
        request.weight = weight
        json = request.json
        XCTAssertEqual(json["weight"] as! Int, weight)
    }
    
    // ----------------------------------
    //  MARK: - Update Request -
    //
    func testUpdateRequest() {
        var request = Record.UpdateRequest()
        var json    = request.json
        
        XCTAssertNil(json["type"])
        XCTAssertNil(json["name"])
        XCTAssertNil(json["data"])
        XCTAssertNil(json["priority"])
        XCTAssertNil(json["port"])
        XCTAssertNil(json["weight"])
        
        let kind     = Record.Kind.a
        request.kind = kind
        json = request.json
        XCTAssertEqual(json["type"] as! String, kind.rawValue)
        
        let name     = "@"
        request.name = name
        json = request.json
        XCTAssertEqual(json["name"] as! String, name)
        
        let value     = "12.12.12.12"
        request.value = value
        json = request.json
        XCTAssertEqual(json["data"] as! String, value)
        
        let priority     = 10
        request.priority = priority
        json = request.json
        XCTAssertEqual(json["priority"] as! Int, priority)
        
        let port     = 80
        request.port = port
        json = request.json
        XCTAssertEqual(json["port"] as! Int, port)
        
        let weight     = 5
        request.weight = weight
        json = request.json
        XCTAssertEqual(json["weight"] as! Int, weight)
    }
}
