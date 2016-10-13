//
//  FloatingIPTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class FloatingIPTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreationWithDroplet() {
        let model:   FloatingIP = self.modelNamed(name: "floatingIPWithDroplet")
        let droplet: Droplet    = self.modelNamed(name: "droplet")
        let region:  Region     = self.modelNamed(name: "region")
        
        
        XCTAssertEqual(model.ip,      "12.12.12.12")
        XCTAssertEqual(model.droplet, droplet)
        XCTAssertEqual(model.region,  region)
    }
    
    func testJsonCreationWithoutDroplet() {
        let model:  FloatingIP = self.modelNamed(name: "floatingIPWithoutDroplet")
        let region: Region     = self.modelNamed(name: "region")
        
        
        XCTAssertEqual(model.ip,      "12.12.12.12")
        XCTAssertEqual(model.region,  region)
        XCTAssertEqual(model.droplet, nil)
    }
    
    func testEqualityWithDroplet() {
        self.assertEqualityForModelNamed(type: FloatingIP.self, name: "floatingIPWithDroplet")
    }
    
    func testEqualityWithoutDroplet() {
        self.assertEqualityForModelNamed(type: FloatingIP.self, name: "floatingIPWithoutDroplet")
    }
}
