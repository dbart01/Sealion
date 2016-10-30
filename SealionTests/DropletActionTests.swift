//
//  DropletActionTests.swift
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

import XCTest
import Sealion

class DropletActionTests: XCTestCase {
    
    func testPasswordReset() {
        self.assertDropletAction(action: .passwordReset, against: [
            "type" : "password_reset",
        ])
    }
    
    func testEnableBackups() {
        self.assertDropletAction(action: .enableBackups, against: [
            "type" : "enable_backups",
        ])
    }
    
    func testEnableIpv6() {
        self.assertDropletAction(action: .enableIpv6, against: [
            "type" : "enable_ipv6",
        ])
    }
    
    func testEnablePrivateNetworking() {
        self.assertDropletAction(action: .enablePrivateNetworking, against: [
            "type" : "enable_private_networking",
        ])
    }
    
    func testDisableBackups() {
        self.assertDropletAction(action: .disableBackups, against: [
            "type" : "disable_backups",
        ])
    }
    
    func testReboot() {
        self.assertDropletAction(action: .reboot, against: [
            "type" : "reboot",
        ])
    }
    
    func testPowerCycle() {
        self.assertDropletAction(action: .powerCycle, against: [
            "type" : "power_cycle",
        ])
    }
    
    func testShutdown() {
        self.assertDropletAction(action: .shutdown, against: [
            "type" : "shutdown",
        ])
    }
    
    func testPowerOff() {
        self.assertDropletAction(action: .powerOff, against: [
            "type" : "power_off",
        ])
    }
    
    func testPowerOn() {
        self.assertDropletAction(action: .powerOn, against: [
            "type" : "power_on",
        ])
    }
    
    func testRestore() {
        self.assertDropletAction(action: .restore(image: 123), against: [
            "type"  : "restore",
            "image" : 123,
        ])
    }
    
    func testResize() {
        let disk = true
        let size = "1gb"
        self.assertDropletAction(action: .resize(disk: disk, sizeSlug: size), against: [
            "type" : "resize",
            "disk" : disk,
            "size" : size,
        ])
    }
    
    func testRebuild() {
        let image = "123"
        self.assertDropletAction(action: .rebuild(image: image), against: [
            "type"  : "rebuild",
            "image" : image,
        ])
    }
    
    func testRename() {
        let name = "New Droplet"
        self.assertDropletAction(action: .rename(name: name), against: [
            "type" : "rename",
            "name" : name,
        ])
    }
    
    func testChangeKernel() {
        let id = 123
        self.assertDropletAction(action: .changeKernel(id: id), against: [
            "type"   : "change_kernel",
            "kernel" : id,
        ])
    }
    
    func testCreateSnapshot() {
        let name = "New Snapshot"
        self.assertDropletAction(action: .createSnapshot(name: name), against: [
            "type" : "snapshot",
            "name" : name,
        ])
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func assertDropletAction(action: DropletAction, against expectation: Any) {
        XCTAssertTrue(action.json == expectation as! JSON)
    }
}
