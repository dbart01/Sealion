//
//  Account.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-02.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct Account: JsonCreatable, Equatable {
    
    public let dropletLimit:    Int
    public let floatingIPLimit: Int
    public let verified:        Bool
    public let email:           String
    public let uuid:            String
    public let status:          String
    public let message:         String
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: [String : Any]) {
        self.dropletLimit    = json["droplet_limit"]     as! Int
        self.floatingIPLimit = json["floating_ip_limit"] as! Int
        self.verified        = json["email_verified"]    as! Bool
        self.email           = json["email"]             as! String
        self.uuid            = json["uuid"]              as! String
        self.status          = json["status"]            as! String
        self.message         = json["status_message"]    as! String
    }
}

public func ==(lhs: Account, rhs: Account) -> Bool {
    return (lhs.dropletLimit == rhs.dropletLimit) &&
    (lhs.floatingIPLimit == rhs.floatingIPLimit) &&
    (lhs.verified        == rhs.verified) &&
    (lhs.email           == rhs.email) &&
    (lhs.uuid            == rhs.uuid) &&
    (lhs.status          == rhs.status) &&
    (lhs.message         == rhs.message)
}
