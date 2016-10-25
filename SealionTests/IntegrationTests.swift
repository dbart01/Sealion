//
//  IntegrationTests.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-16.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class IntegrationTests: XCTestCase {
    
    typealias Block = () -> Void
    
    let api = API(version: .v2, token: "a4b2f1b7e1f10dab178375189f2a285a18abee5f4e353dcfedae7087e9e25463")
    
    // ----------------------------------
    //  MARK: - Everything -
    //
    func testEverything() {
        self.fetchImages()
        let droplet = self.createDroplet()
        _ = self.pollDropletUntilActive(dropletToPoll: droplet)
        self.deleteDroplet(droplet: droplet)
    }
    
    // ----------------------------------
    //  MARK: - Images -
    //
    private func fetchImages() {
        let e = self.expectation(description: "Fetch Images")
        
        let handle = self.api.images(type: .distribution, page: Page(index: 0, count: 200)) { result in
            print("Result: \(result)")
            e.fulfill()
        }
        handle.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    // ----------------------------------
    //  MARK: - Droplet -
    //
    private func createDroplet() -> Droplet {
        let e = self.expectation(description: "Create droplet")
        
        var droplet: Droplet?
        
        let request = Droplet.CreateRequest(name: "test-droplet", region: "nyc3", size: "512mb", image: "ubuntu-14-04-x64")
        let handle  = self.api.create(droplet: request) { result in
            switch result {
            case .success(let d):
                droplet = d!
            case .failure(let error, _):
                XCTFail(error?.description ?? "Failed to create droplet")
            }
            e.fulfill()
        }
        handle.resume()
    
        self.waitForExpectations(timeout: 10.0, handler: nil)
        return droplet!
    }
    
    private func pollDropletUntilActive(dropletToPoll: Droplet) -> Droplet {
        let e = self.expectation(description: "Poll droplet")
        
        var droplet: Droplet?
        
        let handle  = self.api.poll(droplet: dropletToPoll.id, status: .active) { result in
            switch result {
            case .success(let d):
                droplet = d!
            case .failure(let error, _):
                XCTFail(error?.description ?? "Failed to poll droplet")
            }
            e.fulfill()
        }
        handle.resume()
        
        self.waitForExpectations(timeout: 300.0, handler: nil)
        return droplet!
    }
    
    private func deleteDroplet(droplet: Droplet) {
        let e = self.expectation(description: "Delete droplet")
        
        let handle  = self.api.delete(droplet: droplet.id) { result in
            switch result {
            case .success:
                break
            case .failure(let error, _):
                XCTFail(error?.description ?? "Failed to delete droplet")
            }
            e.fulfill()
        }
        handle.resume()
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
