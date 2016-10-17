//
//  FloatingIP.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-13.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct FloatingIP: JsonCreatable, Equatable {
    
    public let ip:      String
    public let droplet: Droplet?
    public let region:  Region
    
    // ----------------------------------
    //  MARK: - JsonCreatable -
    //
    public init(json: JSON) {
        self.ip      = json["ip"] as! String
        self.region  = Region(json:  json["region"]  as! JSON)
        self.droplet = Droplet(json: json["droplet"] as? JSON)    }
}

public func ==(lhs: FloatingIP, rhs: FloatingIP) -> Bool {
    return (lhs.ip == rhs.ip) &&
        (lhs.droplet == rhs.droplet) &&
        (lhs.region  == rhs.region)
}

// ----------------------------------
//  MARK: - Creation -
//
public extension FloatingIP {
    
    public struct CreateRequestRegion: JsonConvertible {
        
        public var region: String
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(region: String) {
            self.region = region
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            return ["region" : self.region]
        }
    }
    
    public struct CreateRequestDroplet: JsonConvertible {
        
        public var droplet: Int
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(droplet: Int) {
            self.droplet = droplet
        }
        
        // ----------------------------------
        //  MARK: - JsonConvertible -
        //
        public var json: JSON {
            return ["droplet_id" : self.droplet]
        }
    }
}
