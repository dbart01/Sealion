//
//  API+VolumesTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class API_VolumesTests: APITestCase {
    
    func testVolumesList() {
        self.mockUsing(name: "volumesSuccess")
        let e = self.expectation(description: "")
        
        self.api.volumes { result in
            
            if case .success(let volumes) = result {
                guard let volumes = volumes else {
                    XCTFail("Expecting a non-nil actions.")
                    return
                }
                
                XCTAssertEqual(volumes.count, 1)
                
                let volume = volumes[0]
                
                XCTAssertEqual(volume.id,          "506f78a4-e098-11e5-ad9f-000f53306ae1")
                XCTAssertEqual(volume.name,        "example")
                XCTAssertEqual(volume.description, "Block store for examples")
                XCTAssertEqual(volume.dropletIDs,  [20123018])
                XCTAssertEqual(volume.size,        10)
                XCTAssertEqual(volume.createdAt,   Date(ISOString: "2016-03-02T17:00:49Z"))
                XCTAssertNotNil(volume.region)
                
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
}
