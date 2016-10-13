//
//  API+DropletSizeTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_SizeTests: APITestCase {
    
    func testSizeList() {
        let handle = self.api.sizes { result in }
        
        self.assertType(handle, type: [DropletSize].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .sizes)
        self.assertKeyPath(handle, keyPath: "sizes")
        self.assertParameters(handle, parameters: nil)
    }
}
