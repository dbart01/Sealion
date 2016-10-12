//
//  DropletAction.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-11.
//  Copyright © 2016 Dima Bart. All rights reserved.
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
