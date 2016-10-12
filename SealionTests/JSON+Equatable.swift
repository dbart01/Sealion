//
//  Dictionary+Equatable.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-11.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation
import Sealion

func ==(lhs: JSON, rhs: JSON) -> Bool {
    let lhsData = try! JSONSerialization.data(withJSONObject: lhs, options: [])
    let rhsData = try! JSONSerialization.data(withJSONObject: rhs, options: [])
    
    return lhsData == rhsData
}
