//
//  Size.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public extension Droplet {
    public struct Size: JsonCreatable, Equatable {
        
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
}

public func ==(lhs: Droplet.Size, rhs: Droplet.Size) -> Bool {
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
