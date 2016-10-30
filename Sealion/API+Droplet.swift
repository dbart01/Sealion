//
//  API+Droplet.swift
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
    
    public func droplets(tag: String? = nil, page: Page? = nil, completion: @escaping (_ result: Result<[Droplet]>) -> Void) -> Handle<[Droplet]> {
        let parameters: Parameters? = (tag == nil) ? nil : ["tag_name" : tag!]
        let request = self.requestTo(endpoint: .droplets, method: .get, page: page, parameters: parameters)
        return self.taskWith(request: request, keyPath: "droplets", completion: completion)
    }
    
    public func dropletWith(id: Int, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .dropletWithID(id), method: .get)
        return self.taskWith(request: request, keyPath: "droplet", completion: completion)
    }
    
    public func create(droplet: Droplet.CreateRequest, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .droplets, method: .post, payload: droplet)
        return self.taskWith(request: request, keyPath: "droplet", completion: completion)
    }
    
    public func create(droplets: Droplet.CreateRequest, completion: @escaping (_ result: Result<[Droplet]>) -> Void) -> Handle<[Droplet]> {
        let request = self.requestTo(endpoint: .droplets, method: .post, payload: droplets)
        return self.taskWith(request: request, keyPath: "droplets", completion: completion)
    }
    
    public func delete(droplet id: Int, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .dropletWithID(id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
    
    public func delete(droplets tag: String, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .droplets, method: .delete, parameters: ["tag_name" : tag])
        return self.taskWith(request: request, completion: completion)
    }
    
    public func poll(droplet id: Int, status: Droplet.Status, completion: @escaping (_ result: Result<Droplet>) -> Void) -> Handle<Droplet> {
        let request = self.requestTo(endpoint: .dropletWithID(id), method: .get)
        return self.taskWith(request: request, keyPath: "droplet", pollHandler: { result in
            
            print("Polling droplet...")
            if case .success(let droplet) = result, droplet != nil {
                return droplet!.status != status
            }
            return false
            
        }, completion: completion)
    }
}
