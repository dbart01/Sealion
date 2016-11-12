//
//  Result.swift
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

public enum FailureReason {
    
    case unknown
    case cancelled
    case badURL
    case timedOut
    case unsupportedURL
    case cannotFindHost
    case cannotConnectToHost
    case networkConnectionLost
    case dNSLookupFailed
    case HTTPTooManyRedirects
    case resourceUnavailable
    case notConnectedToInternet
    case redirectToNonExistentLocation
    case badServerResponse
    case userCancelledAuthentication
    case userAuthenticationRequired
    case zeroByteResource
    case cannotDecodeRawData
    case cannotDecodeContentData
    case cannotParseResponse
    case fileDoesNotExist
    case fileIsDirectory
    case noPermissionsToReadFile
    case dataLengthExceedsMaximum
    case requiresSecureConnection
    
    init(code: Int?) {
        guard let code = code else {
            self = .unknown
            return
        }
        
        switch code {
        case NSURLErrorUnknown:                       self = .unknown
        case NSURLErrorCancelled:                     self = .cancelled
        case NSURLErrorBadURL:                        self = .badURL
        case NSURLErrorTimedOut:                      self = .timedOut
        case NSURLErrorUnsupportedURL:                self = .unsupportedURL
        case NSURLErrorCannotFindHost:                self = .cannotFindHost
        case NSURLErrorCannotConnectToHost:           self = .cannotConnectToHost
        case NSURLErrorNetworkConnectionLost:         self = .networkConnectionLost
        case NSURLErrorDNSLookupFailed:               self = .dNSLookupFailed
        case NSURLErrorHTTPTooManyRedirects:          self = .HTTPTooManyRedirects
        case NSURLErrorResourceUnavailable:           self = .resourceUnavailable
        case NSURLErrorNotConnectedToInternet:        self = .notConnectedToInternet
        case NSURLErrorRedirectToNonExistentLocation: self = .redirectToNonExistentLocation
        case NSURLErrorBadServerResponse:             self = .badServerResponse
        case NSURLErrorUserCancelledAuthentication:   self = .userCancelledAuthentication
        case NSURLErrorUserAuthenticationRequired:    self = .userAuthenticationRequired
        case NSURLErrorZeroByteResource:              self = .zeroByteResource
        case NSURLErrorCannotDecodeRawData:           self = .cannotDecodeRawData
        case NSURLErrorCannotDecodeContentData:       self = .cannotDecodeContentData
        case NSURLErrorCannotParseResponse:           self = .cannotParseResponse
        case NSURLErrorFileDoesNotExist:              self = .fileDoesNotExist
        case NSURLErrorFileIsDirectory:               self = .fileIsDirectory
        case NSURLErrorNoPermissionsToReadFile:       self = .noPermissionsToReadFile
        case NSURLErrorDataLengthExceedsMaximum:      self = .dataLengthExceedsMaximum
        case NSURLErrorAppTransportSecurityRequiresSecureConnection: self = .requiresSecureConnection
        default:
            self = .unknown
        }
    }
}

public enum Result<T> {   
    case success(object: T?)
    case failure(error: RequestError?, reason: FailureReason)
}
