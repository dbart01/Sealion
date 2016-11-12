//
//  FloatingIP.swift
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
