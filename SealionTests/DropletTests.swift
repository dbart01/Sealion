//
//  DropletTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-07.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class DropletTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model:     Droplet      = self.modelNamed(name: "droplet")
        let kernel:    Kernel       = self.modelNamed(name: "kernel")
        let window:    BackupWindow = self.modelNamed(name: "backupWindow")
        let image:     Image        = self.modelNamed(name: "image")
        let size:      Droplet.Size = self.modelNamed(name: "size")
        let region:    Region       = self.modelNamed(name: "region")
        let v4Network: Network      = self.modelNamed(name: "v4Network")
        let v6Network: Network      = self.modelNamed(name: "v6Network")
        
        
        XCTAssertEqual(model.id,          123)
        XCTAssertEqual(model.name,        "some.droplet.com")
        XCTAssertEqual(model.locked,      false)
        XCTAssertEqual(model.status,      "active")
        XCTAssertEqual(model.features,    ["virtio"])
        XCTAssertEqual(model.tags,        ["awesome"])
        XCTAssertEqual(model.backupIDs,   [123, 234])
        XCTAssertEqual(model.snapshotIDs, [345, 456])
        XCTAssertEqual(model.volumeIDs,   [567, 678])
        XCTAssertEqual(model.createdAt,   Date(ISOString: "2015-08-07T19:50:26Z"))
        
        XCTAssertEqual(model.kernel,     kernel)
        XCTAssertEqual(model.nextWindow, window)
        XCTAssertEqual(model.image,      image)
        XCTAssertEqual(model.size,       size)
        XCTAssertEqual(model.region,     region)
        XCTAssertEqual(model.v4Networks, [v4Network])
        XCTAssertEqual(model.v6Networks, [v6Network])
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Droplet.self, name: "droplet")
    }
}
