//
//  DateFormatter.swift
//  Sealion
//
//  Created by Dima Bart on 2016-10-03.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

internal extension Date {
    
    internal static let ISOFormatter: DateFormatter = {
        let formatter        = DateFormatter()
        formatter.locale     = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    internal init(ISOString: String) {
        self = Date.ISOFormatter.date(from: ISOString)!
    }
    
    internal var ISOString: String {
        return Date.ISOFormatter.string(from: self)
    }
}
