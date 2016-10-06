//
//  Person.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-05.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation
import Sealion

struct Person: JsonCreatable {
    
    let firstName: String
    let lastName:  String
    
    init(json: JSON) {
        self.firstName = json["firstName"] as! String
        self.lastName  = json["lastName"]  as! String
    }
}
