//
//  API+FloatingIPAction.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func action(create action: FloatingIPAction, for ip: String, completion: @escaping (_ result: Result<Action>) -> Void) -> Handle<Action> {
        let request = self.requestTo(endpoint: .floatingIPActionsWithIP(ip), method: .post, payload: action)
        return self.taskWith(request: request, keyPath: "action", completion: completion)
    }
    
    public func actionsFor(floatingIP: String, completion: @escaping (_ result: Result<[Action]>) -> Void) -> Handle<[Action]> {
        let request = self.requestTo(endpoint: .floatingIPActionsWithIP(floatingIP), method: .get)
        return self.taskWith(request: request, keyPath: "actions", completion: completion)
    }
}
