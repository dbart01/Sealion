//
//  API+ImageAction.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-15.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func action(create action: ImageAction, for id: Int, completion: @escaping (_ result: Result<Action>) -> Void) -> Handle<Action> {
        let request = self.requestTo(endpoint: .imageActionsWithID(id), method: .post, payload: action)
        return self.taskWith(request: request, keyPath: "action", completion: completion)
    }
    
    public func actionsFor(image: Int, completion: @escaping (_ result: Result<[Action]>) -> Void) -> Handle<[Action]> {
        let request = self.requestTo(endpoint: .imageActionsWithID(image), method: .get)
        return self.taskWith(request: request, keyPath: "actions", completion: completion)
    }
}
