//
//  API+FloatingIP.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func floatingIPs(page: Page? = nil, completion: @escaping (_ result: Result<[FloatingIP]>) -> Void) -> Handle<[FloatingIP]> {
        let request = self.requestTo(endpoint: .floatingIPs, method: .get, page: page)
        return self.taskWith(request: request, keyPath: "floating_ips", completion: completion)
    }
    
    public func floatingIPWith(ip: String, completion: @escaping (_ result: Result<FloatingIP>) -> Void) -> Handle<FloatingIP> {
        let request = self.requestTo(endpoint: .floatingIPWithIP(ip), method: .get)
        return self.taskWith(request: request, keyPath: "floating_ip", completion: completion)
    }
    
    public func create(floatingIPFor droplet: FloatingIP.CreateRequestDroplet, completion: @escaping (_ result: Result<FloatingIP>) -> Void) -> Handle<FloatingIP> {
        let request = self.requestTo(endpoint: .floatingIPs, method: .post, payload: droplet)
        return self.taskWith(request: request, keyPath: "floating_ip", completion: completion)
    }
    
    public func create(floatingIPFor region: FloatingIP.CreateRequestRegion, completion: @escaping (_ result: Result<FloatingIP>) -> Void) -> Handle<FloatingIP> {
        let request = self.requestTo(endpoint: .floatingIPs, method: .post, payload: region)
        return self.taskWith(request: request, keyPath: "floating_ip", completion: completion)
    }
    
    public func delete(floatingIP ip: String, completion: @escaping (_ result: Result<FloatingIP>) -> Void) -> Handle<FloatingIP> {
        let request = self.requestTo(endpoint: .floatingIPWithIP(ip), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
}
