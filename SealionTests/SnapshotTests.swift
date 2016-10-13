//
//  SnapshotTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class SnapshotTests: ModelTestCase {
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    func testJsonCreation() {
        let model: Snapshot = self.modelNamed(name: "snapshot")
        
        XCTAssertEqual(model.id,             123)
        XCTAssertEqual(model.resourceID,     234)
        XCTAssertEqual(model.name,           "test-snapshot")
        XCTAssertEqual(model.resourceType,   "droplet")
        XCTAssertEqual(model.regionSlugs,    ["tor1"])
        XCTAssertEqual(model.minimumDiskSize, 20.0)
        XCTAssertEqual(model.size,            0.5)
        XCTAssertEqual(model.createdAt,       Date(ISOString: "2016-09-10T18:06:25Z"))
    }
    
    func testEquality() {
        self.assertEqualityForModelNamed(type: Snapshot.self, name: "snapshot")
    }
    
    // ----------------------------------
    //  MARK: - ImageType -
    //
    func testImageTypes() {
        
        let dropletType = Snapshot.SnapshotType.droplet
        XCTAssertTrue(dropletType.parameters == [
            "resource_type" : "droplet"
        ])
        
        let volumeType = Snapshot.SnapshotType.volume
        XCTAssertTrue(volumeType.parameters == [
            "resource_type" : "volume"
        ])
    }
}
