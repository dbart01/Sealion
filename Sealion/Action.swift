//
//  Action.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Action: JsonCreatable, Equatable {
    
    public let id:           Int
    public let resourceID:   Int
    public let status:       String
    public let type:         String
    public let startedAt:    Date
    public let finishedAt:   Date
    public let resourceType: String
    public let region:       Region?
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.id           = json["id"]            as! Int
        self.resourceID   = json["resource_id"]   as! Int
        self.status       = json["status"]        as! String
        self.type         = json["type"]          as! String
        self.resourceType = json["resource_type"] as! String
        self.startedAt    = Date(ISOString: json["started_at"]   as! String)!
        self.finishedAt   = Date(ISOString: json["completed_at"] as! String)!
        
        if let regionJSON = json["region"] as? JSON {
            self.region = Region(json: regionJSON)
        } else {
            self.region = nil
        }
    }
}

public func ==(lhs: Action, rhs: Action) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.resourceID   == rhs.resourceID) &&
        (lhs.status       == rhs.status) &&
        (lhs.type         == rhs.type) &&
        (lhs.startedAt    == rhs.startedAt) &&
        (lhs.finishedAt   == rhs.finishedAt) &&
        (lhs.resourceType == rhs.resourceType)
}
