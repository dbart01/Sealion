//
//  ModelTestCase.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
import Sealion

class ModelTestCase: APITestCase {
    
    private let jsonManager = JsonManager(jsonNamed: "models")
    
    // ----------------------------------
    //  MARK: - Json Models -
    //
    func modelNamed(name: String) -> JSON {
        return self.jsonManager.modelJsonFor(key: name)
    }
    
    // ----------------------------------
    //  MARK: - Assertions -
    //
    func assertEqualityForModelNamed<T>(type: T.Type, name: String) where T: JsonCreatable, T: Equatable {
        let model1 = T(json: self.modelNamed(name: "account"))
        let model2 = T(json: self.modelNamed(name: "account"))
        
        XCTAssertEqual(model1, model2)
    }
}
