//
//  API+VolumeAction.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-14.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func action(create action: VolumeAction, completion: @escaping (_ result: Result<Action>) -> Void) -> Handle<Action> {
        let request = self.requestTo(endpoint: .volumeActions, method: .post, payload: action)
        return self.taskWith(request: request, keyPath: "action", completion: completion)
    }
    
    public func action(create action: VolumeAction, for id: Int, completion: @escaping (_ result: Result<Action>) -> Void) -> Handle<Action> {
        let request = self.requestTo(endpoint: .volumeActionsWithID(id), method: .post, payload: action)
        return self.taskWith(request: request, keyPath: "action", completion: completion)
    }
}
