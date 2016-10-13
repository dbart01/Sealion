//
//  API+SnapshotTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_SnapshotTests: APITestCase {
    
    func testSnapshotList() {
        let handle = self.api.snapshots { result in }
        
        self.assertType(handle, type: [Snapshot].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshots)
        self.assertKeyPath(handle, keyPath: "snapshots")
        self.assertParameters(handle, parameters: nil)
        
        let handleWithParameters = self.api.snapshots(type: .droplet) { result in }
        
        self.assertParameters(handleWithParameters, parameters: [
            "resource_type" : "droplet"
        ])
    }
    
    func testSnapshotWithID() {
        let id     = 123
        let handle = self.api.snapshotWith(id: id) { result in }
        
        self.assertType(handle, type: Snapshot.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshotWithID(id))
        self.assertKeyPath(handle, keyPath: "snapshot")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testSnapshotDelete() {
        let id     = 123
        let handle = self.api.delete(snapshot: 123) { result in }
        
        self.assertType(handle, type: Snapshot.self)
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshotWithID(id))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
}
