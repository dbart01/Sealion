//
//  API+Volume.swift
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
    
    public func volumes(page: Page? = nil, completion: @escaping (_ result: Result<[Volume]>) -> Void) -> Handle<[Volume]> {
        let request = self.requestTo(endpoint: .volumes, method: .get, page: page)
        return self.taskWith(request: request, keyPath: "volumes", completion: completion)
    }
    
    public func volumeWith(id: String, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle<Volume> {
        let request = self.requestTo(endpoint: .volumeWithID(id), method: .get)
        return self.taskWith(request: request, keyPath: "volume", completion: completion)
    }
    
    public func volumeWith(name: Volume.Name, completion: @escaping (_ result: Result<[Volume]>) -> Void) -> Handle<[Volume]> {
        let request = self.requestTo(endpoint: .volumes, method: .get, parameters: name)
        return self.taskWith(request: request, keyPath: "volumes", completion: completion)
    }
    
    public func create(volume: Volume.CreateRequest, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle<Volume> {
        let request = self.requestTo(endpoint: .volumes, method: .post, payload: volume)
        return self.taskWith(request: request, keyPath: "volume", completion: completion)
    }
    
    public func delete(volume id: String, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle<Volume> {
        let request = self.requestTo(endpoint: .volumeWithID(id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
    
    public func delete(volume name: Volume.Name, completion: @escaping (_ result: Result<Volume>) -> Void) -> Handle<Volume> {
        let request = self.requestTo(endpoint: .volumes, method: .delete, parameters: name)
        return self.taskWith(request: request, completion: completion)
    }
}
