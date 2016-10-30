//
//  DropletAction.swift
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

public enum DropletAction: JsonConvertible {
    
    case passwordReset
    case enableBackups
    case enableIpv6
    case enablePrivateNetworking
    case disableBackups
    case reboot
    case powerCycle
    case shutdown
    case powerOff
    case powerOn
    case restore(image: Identifier)
    case resize(disk: Bool, sizeSlug: String)
    case rebuild(image: Identifier)
    case rename(name: String)
    case changeKernel(id: Int)
    case createSnapshot(name: String)
    
    public var json: JSON {
        var container: JSON = [
            "type" : self.type,
            ]
        
        switch self {
        case .restore(let image):
            container["image"] = image
        case .resize(let disk, let sizeSlug):
            container["disk"] = disk
            container["size"] = sizeSlug
        case .rebuild(let image):
            container["image"] = image
        case .rename(let name):
            container["name"] = name
        case .changeKernel(let id):
            container["kernel"] = id
        case .createSnapshot(let name):
            container["name"] = name
        default:
            break
        }
        
        return container
    }
    
    internal var type: String {
        switch self {
        case .passwordReset:           return "password_reset"
        case .enableBackups:           return "enable_backups"
        case .enableIpv6:              return "enable_ipv6"
        case .enablePrivateNetworking: return "enable_private_networking"
        case .disableBackups:          return "disable_backups"
        case .reboot:                  return "reboot"
        case .powerCycle:              return "power_cycle"
        case .shutdown:                return "shutdown"
        case .powerOff:                return "power_off"
        case .powerOn:                 return "power_on"
        case .restore:                 return "restore"
        case .resize:                  return "resize"
        case .rebuild:                 return "rebuild"
        case .rename:                  return "rename"
        case .changeKernel:            return "change_kernel"
        case .createSnapshot:          return "snapshot"
        }
    }
}
