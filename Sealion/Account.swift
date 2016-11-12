//
//  Account.swift
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
    public init(json: JSON) {
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
