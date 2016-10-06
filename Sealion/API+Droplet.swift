//
//  API+Droplet.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func droplets(completion: @escaping (_ result: Result<[Droplet]>) -> Void) {
        let request = self.requestTo(endpoint: .droplets, method: .get)
        let task    = self.taskWith(request: request, keyPath: "droplets", completion: completion)
        
        task.resume()
    }
    public func dropletWith(id: Int, completion: @escaping (_ result: Result<[Droplet]>) -> Void) {
        let request = self.requestTo(endpoint: .dropletWith(id), method: .get)
        let task    = self.taskWith(request: request, keyPath: "droplet", completion: completion)
        
        task.resume()
    }
}
