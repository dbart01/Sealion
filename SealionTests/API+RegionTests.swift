//
//  API+RegionTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_RegionTests: APITestCase {
    
    func testRegionList() {
        let handle = self.api.regions { result in }
        
        self.assertType(handle, type: [Region].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .regions)
        self.assertKeyPath(handle, keyPath: "regions")
        self.assertParameters(handle, parameters: nil)
    }
}
