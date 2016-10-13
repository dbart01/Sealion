//
//  API+FloatingIPTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class API_FloatingIPTests: APITestCase {
    
    func testFloatingIPList() {
        let handle = self.api.floatingIPs { result in }
        
        self.assertType(handle, type: [FloatingIP].self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .floatingIPs)
        self.assertKeyPath(handle, keyPath: "floating_ips")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testFloatingIPWithIP() {
        let ip     = "12.12.12.12"
        let handle = self.api.floatingIPWith(ip: ip) { result in }
        
        self.assertType(handle, type: FloatingIP.self)
        self.assertMethod(handle, method: .get)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .floatingIPWithIP(ip))
        self.assertKeyPath(handle, keyPath: "floating_ip")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testFloatingIPCreateForDroplet() {
        let request = FloatingIP.CreateRequestDroplet(droplet: 123)
        let handle  = self.api.create(floatingIPFor: request) { result in }
        
        self.assertType(handle, type: FloatingIP.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .floatingIPs)
        self.assertKeyPath(handle, keyPath: "floating_ip")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testFloatingIPCreateForRegion() {
        let request = FloatingIP.CreateRequestRegion(region: "nyc3")
        let handle  = self.api.create(floatingIPFor: request) { result in }
        
        self.assertType(handle, type: FloatingIP.self)
        self.assertMethod(handle, method: .post)
        self.assertBody(handle, object: request)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .floatingIPs)
        self.assertKeyPath(handle, keyPath: "floating_ip")
        self.assertParameters(handle, parameters: nil)
    }
    
    func testFloatingIPDelete() {
        let ip     = "12.12.12.12"
        let handle = self.api.delete(floatingIP: ip) { result in }
        
        self.assertType(handle, type: FloatingIP.self)
        self.assertMethod(handle, method: .delete)
        self.assertBody(handle, data: nil)
        self.assertHeaders(handle)
        self.assertEndpoint(handle, endpoint: .floatingIPWithIP(ip))
        self.assertKeyPath(handle, keyPath: nil)
        self.assertParameters(handle, parameters: nil)
    }
}
