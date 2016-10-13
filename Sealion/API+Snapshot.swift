//
//  API+Snapshot.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-12.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension API {
    
    public func snapshots(type: Snapshot.SnapshotType? = nil, page: Page? = nil, completion: @escaping (_ result: Result<[Snapshot]>) -> Void) -> Handle<[Snapshot]> {
        let request = self.requestTo(endpoint: .snapshots, method: .get, parameters: type)
        return self.taskWith(request: request, keyPath: "snapshots", completion: completion)
    }
    
    public func snapshotWith(id: Int, completion: @escaping (_ result: Result<Snapshot>) -> Void) -> Handle<Snapshot> {
        let request = self.requestTo(endpoint: .snapshotWithID(id), method: .get)
        return self.taskWith(request: request, keyPath: "snapshot", completion: completion)
    }

    public func delete(snapshot id: Int, completion: @escaping (_ result: Result<Snapshot>) -> Void) -> Handle<Snapshot> {
        let request = self.requestTo(endpoint: .snapshotWithID(id), method: .delete)
        return self.taskWith(request: request, completion: completion)
    }
}
