//
//  API+Volumes.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-04.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func volumes(completion: @escaping (_ result: Result<[Volume]>) -> Void) {
        let request = self.requestTo(endpoint: .volumes, method: .get)
        let task    = self.taskWith(request: request, keyPath: "volumes", completion: completion)
        
        task.resume()
    }
    
    public func create(volume: Volume.CreateRequest, completion: @escaping (_ result: Result<[Volume]>) -> Void) {
        let request = self.requestTo(endpoint: .volumes, method: .post, payload: volume)
        let task    = self.taskWith(request: request, keyPath: "volumes", completion: completion)
        
        task.resume()
    }
}
