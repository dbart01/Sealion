//
//  API+BackupTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-16.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_BackupTests: APITestCase {
    
    func testSnapshotsForDroplet() {
        let id     = 123
        let handle = self.api.backupsFor(droplet: id) { result in }
        
        self.assertType(handle, type: [Snapshot].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .snapshotsForDroplet(id))
        self.assertKeyPath(handle, keyPath: "backups")
        self.assertParameters(handle, parameters: nil)
    }
}
