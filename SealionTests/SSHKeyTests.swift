//
//  SSHKeyTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class SSHKeyTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreationForV4() {
        let model: SSHKey = self.modelNamed(name: "key")
        
        XCTAssertEqual(model.id,          123)
        XCTAssertEqual(model.name,        "john@John-Smiths-MBP")
        XCTAssertEqual(model.publicKey,   "ssh-rsa AB3")
        XCTAssertEqual(model.fingerprint, "b7:40")
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: SSHKey.self, name: "key")
    }
    
    // ----------------------------------
    //  MARK: - Create Request -
    //
    func testCreateRequest() {
        let name      = "My Key"
        let publicKey = "ssh-key asdf"
        let request   = SSHKey.CreateRequest(name: name, publicKey: publicKey)
        
        let json = request.json
        
        XCTAssertEqual(json["name"]       as! String, name)
        XCTAssertEqual(json["public_key"] as! String, publicKey)
    }
}
