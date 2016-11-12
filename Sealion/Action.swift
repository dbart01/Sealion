//
//  Action.swift
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

public struct Action: JsonCreatable, Equatable {
    
    public let id:           Int
    public let resourceID:   Int
    public let status:       String
    public let type:         String
    public let startedAt:    Date
    public let finishedAt:   Date
    public let resourceType: String
    public let region:       String?
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.id           = json["id"]            as! Int
        self.resourceID   = json["resource_id"]   as! Int
        self.status       = json["status"]        as! String
        self.type         = json["type"]          as! String
        self.resourceType = json["resource_type"] as! String
        self.region       = json["region_slug"]   as? String
        self.startedAt    = Date(ISOString: json["started_at"]   as! String)!
        self.finishedAt   = Date(ISOString: json["completed_at"] as! String)!
    }
}

public func ==(lhs: Action, rhs: Action) -> Bool {
    return (lhs.id == rhs.id) &&
        (lhs.resourceID   == rhs.resourceID) &&
        (lhs.status       == rhs.status) &&
        (lhs.type         == rhs.type) &&
        (lhs.startedAt    == rhs.startedAt) &&
        (lhs.finishedAt   == rhs.finishedAt) &&
        (lhs.region       == rhs.region) &&
        (lhs.resourceType == rhs.resourceType)
}
