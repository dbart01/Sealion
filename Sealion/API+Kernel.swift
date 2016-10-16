//
//  API+Kernel.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-16.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func kernelsFor(droplet: Int, page: Page? = nil, completion: @escaping (_ result: Result<[Kernel]>) -> Void) -> Handle<[Kernel]> {
        let request = self.requestTo(endpoint: .kernelsForDroplet(droplet), method: .get, page: page)
        return self.taskWith(request: request, keyPath: "kernels", completion: completion)
    }
}
