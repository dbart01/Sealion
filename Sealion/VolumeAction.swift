//
//  VolumeAction.swift
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

public enum VolumeAction: JsonConvertible {
    
    case attachTo(droplet: Int, region: String)
    case detachFrom(droplet: Int, region: String)
    case attach(volume: String, droplet: Int, region: String)
    case detach(volume: String, droplet: Int, region: String)
    case resize(GB: Int, region: String)
    
    public var json: JSON {
        var container: JSON = [
            "type" : self.type,
        ]
        
        switch self {
        case .attachTo(let droplet, let region):
            container["droplet_id"]  = droplet
            container["region"]      = region
        case .detachFrom(let droplet, let region):
            container["droplet_id"]  = droplet
            container["region"]      = region
        case .attach(let volume, let droplet, let region):
            container["volume_name"] = volume
            container["droplet_id"]  = droplet
            container["region"]      = region
        case .detach(let volume, let droplet, let region):
            container["volume_name"] = volume
            container["droplet_id"]  = droplet
            container["region"]      = region
        case .resize(let GB, let region):
            container["size_gigabytes"] = GB
            container["region"]         = region
        }
        
        return container
    }
    
    internal var type: String {
        switch self {
        case .attachTo:   fallthrough
        case .attach:     return "attach"
        case .detachFrom: fallthrough
        case .detach:     return "detach"
        case .resize:     return "resize"
        }
    }
}
