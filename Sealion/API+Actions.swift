//
//  API+Actions.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func actions(completion: @escaping (_ result: Result<[Action]>) -> Void) {
        let request = self.requestTo(endpoint: .actions, method: .get)
        let task    = self.taskWith(request: request, keyPath: "actions", completion: completion)
        
        task.resume()
    }
    
    public func actionWith(id: Int, completion: @escaping (_ result: Result<Action>) -> Void) {
        let request = self.requestTo(endpoint: .actionWith(id), method: .get)
        let task    = self.taskWith(request: request, keyPath: "action", completion: completion)
        
        task.resume()
    }
}
