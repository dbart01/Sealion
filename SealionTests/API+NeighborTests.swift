//
//  API+NeighborTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-16.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_NeighborTests: APITestCase {
    
    func testNeighborList() {
        let handle = self.api.neighbors { result in }
        
        self.assertType(handle, type: [Droplet].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .neighbors)
        self.assertKeyPath(handle, keyPath: "neighbors")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testNeighborsForDroplet() {
        let id     = 123
        let handle = self.api.neighborsFor(droplet: id) { result in }
        
        self.assertType(handle, type: [Droplet].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .neighborsForDroplet(id))
        self.assertKeyPath(handle, keyPath: "neighbors")
        self.assertParameters(handle, parameters: nil)
    }
}
