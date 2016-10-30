//
//  DropletSize.swift
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

public struct DropletSize: JsonCreatable, Equatable {
    
    public let slug:         String
    public let available:    Bool
    public let memory:       Int
    public let vcpus:        Int
    public let disk:         Int
    public let transfer:     Int
    public let priceMonthly: Double
    public let priceHourly:  Double
    public let regions:      [String]
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.slug         = json["slug"]          as! String
        self.available    = json["available"]     as! Bool
        self.memory       = json["memory"]        as! Int
        self.vcpus        = json["vcpus"]         as! Int
        self.disk         = json["disk"]          as! Int
        self.transfer     = json["transfer"]      as! Int
        self.priceMonthly = json["price_monthly"] as! Double
        self.priceHourly  = json["price_hourly"]  as! Double
        self.regions      = json["regions"]       as! [String]
    }
}

public func ==(lhs: DropletSize, rhs: DropletSize) -> Bool {
    return (lhs.slug == rhs.slug) &&
        (lhs.available    == rhs.available) &&
        (lhs.memory       == rhs.memory) &&
        (lhs.vcpus        == rhs.vcpus) &&
        (lhs.disk         == rhs.disk) &&
        (lhs.transfer     == rhs.transfer) &&
        (lhs.priceMonthly == rhs.priceMonthly) &&
        (lhs.priceHourly  == rhs.priceHourly) &&
        (lhs.regions      == rhs.regions)
}
