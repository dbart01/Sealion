//
//  API+ActionsTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import Sealion

class API_ActionsTests: APITestCase {
    
    func testActionsList() {
        self.mockUsing(name: "actionsSuccess")
        let e = self.expectation(description: "")
        
        self.api.actions { result in

            if case .success(let actions) = result {
                guard let actions = actions else {
                    XCTFail("Expecting a non-nil actions.")
                    return
                }
                
                XCTAssertEqual(actions.count, 2)
                
                let action = actions[0]
                
                XCTAssertEqual(action.id,           6466251)
                XCTAssertEqual(action.resourceID,   20123018)
                XCTAssertEqual(action.resourceType, "droplet")
                XCTAssertEqual(action.status,       "completed")
                XCTAssertEqual(action.type,         "snapshot")
                XCTAssertEqual(action.finishedAt,   Date(ISOString: "2016-09-30T19:52:21Z"))
                XCTAssertEqual(action.startedAt,    Date(ISOString: "2016-09-30T19:52:21Z"))
                
                XCTAssertNotNil(action.region)
                
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
    
    func testActionWithID() {
        self.mockUsing(name: "actionWithIDSuccess")
        let e  = self.expectation(description: "")
        let id = 150675425
        
        self.api.actionWith(id: id) { result in
            
            if case .success(let action) = result {
                XCTAssertNotNil(action)
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
}
