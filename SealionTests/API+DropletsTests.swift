//
//  API+DropletsTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class API_DropletsTests: APITestCase {

    
    func testDropletList() {
        self.mockUsing(name: "droplets")
        let e = self.expectation(description: "")
        
        self.api.droplets { result in
            
            if case .success(let droplets) = result {
                
                XCTAssertNotNil(droplets)
                XCTAssertEqual(droplets!.count, 1)
                
                let droplet = droplets![0]
                
                XCTAssertEqual(droplet.id,        6263251)
                XCTAssertEqual(droplet.name,      "test.server.com")
                XCTAssertEqual(droplet.locked,    false)
                XCTAssertEqual(droplet.status,    "active")
                XCTAssertEqual(droplet.features,  ["virtio"])
                XCTAssertEqual(droplet.tags,      ["cool", "neat"])
                XCTAssertEqual(droplet.createdAt, Date(ISOString: "2015-08-07T19:50:26Z"))
                XCTAssertNotNil(droplet.region)
                
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
}
