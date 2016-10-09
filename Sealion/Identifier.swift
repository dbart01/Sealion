//
//  Identifier.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public protocol Identifier {}

extension Int:    Identifier {}
extension String: Identifier {}
