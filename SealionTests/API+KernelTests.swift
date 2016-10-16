//
//  API+KernelTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-16.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

import XCTest
import Sealion

class API_KernelTests: APITestCase {
    
    func testKernels() {
        let id     = 123
        let handle = self.api.kernelsFor(droplet: id) { result in }
        
        self.assertType(handle, type: [Kernel].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .kernelsForDroplet(id))
        self.assertKeyPath(handle, keyPath: "kernels")
        self.assertParameters(handle, parameters: nil)
    }
}
