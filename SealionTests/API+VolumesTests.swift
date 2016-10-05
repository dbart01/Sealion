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
        self.mockUsing(name: "volumes")
        let e = self.expectation(description: "")
        
        self.api.volumes { result in
            
            if case .success(let volumes) = result {
                
                XCTAssertNotNil(volumes)
                XCTAssertEqual(volumes!.count, 1)
                
                let volume = volumes![0]
                
                XCTAssertEqual(volume.id,          "506f78a4-e098-11e5-ad9f-000f53306ae1")
                XCTAssertEqual(volume.name,        "test")
                XCTAssertEqual(volume.description, "Test volume created from tests.")
                XCTAssertEqual(volume.dropletIDs,  [])
                XCTAssertEqual(volume.size,        1)
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
    
    func testVolumeCreate() {
        self.mockUsing(name: "volumes")
        let e = self.expectation(description: "")
        
        let volume = Volume.CreateRequest(size: 1, name: "test", regionSlug: "nyc1", description: "Test volume created from tests.")
        self.api.create(volume: volume) { result in
            
            if case .success(let volumes) = result {
                
                XCTAssertNotNil(volumes)
                XCTAssertEqual(volumes!.count, 1)
                
                let createdVolume = volumes![0]
                
                XCTAssertEqual(volume.size,        createdVolume.size)
                XCTAssertEqual(volume.name,        createdVolume.name)
                XCTAssertEqual(volume.regionSlug,  createdVolume.region.slug)
                XCTAssertEqual(volume.description, volume.description)
                
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
    
    func testVolumeWithID() {
        self.mockUsing(name: "volumeWithID")
        let e  = self.expectation(description: "")
        let id = ""
        
        self.api.volumeWith(id: id) { result in
            
            if case .success(let volume) = result {
                XCTAssertNotNil(volume)
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
    
    func testVolumeWithName() {
        self.mockUsing(name: "volumes")
        let e  = self.expectation(description: "")
        
        self.api.volumeWith(filter: (name: "test", regionSlug: "nyc1")) { result in
            
            if case .success(let volume) = result {
                XCTAssertNotNil(volume)
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
    
    func testVolumeDelete() {
        self.mockUsing(name: "volumeDelete")
        let e  = self.expectation(description: "")
        let id = ""
        
        self.api.delete(volume: id) { result in
            
            if case .success(let volume) = result {
                XCTAssertNil(volume)
            } else {
                XCTFail("Expecting a successful request.")
            }
            
            e.fulfill()
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
        self.clearMock()
    }
}
