//
//  API+FloatingIP.swift
//  Sealion
//
//  Copyright (c) 2016 Dima Bart
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
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
