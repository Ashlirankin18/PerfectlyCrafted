//
//  AssertionLogging.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/11/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import Foundation
import Crashlytics

/// Logs an assertion failure to Crashlytics, before causing an assertion failure.
///
/// - Parameters:
///   - message: The message of the assertion failure.
///   - file: The file the assertion occurred in.
///   - line: The line the assertion occurred on.
func logAssertionFailure(message: String, file: StaticString = #file, line: UInt = #line) {
    var addresses = Thread.callStackReturnAddresses
    addresses.removeFirst()
    
    let frames = addresses.map { CLSStackFrame(address: $0.uintValue) }
    
    Crashlytics.sharedInstance().recordCustomExceptionName("Assertion Failure", reason: message, frameArray: frames)
    
    assertionFailure(message, file: file, line: line)
}

/// Logs an assertion failure to Crashlytics if the given condition is not true, before causing an assertion failure.
///
/// - Parameters:
///   - condition: The condition to test. The condition is not evaluated for Release build configurations.
///   - message: A string to print if `condition` is evaluated to `false`. The default is an empty string.
///   - file: The file name to print with `message` if the assertion fails. The default is the file where `assertAndLog(_:_:file:line:)` is called.
///   - line: The line number to print along with `message` if the assertion fails. The default is the line number where `assertAndLog(_:_:file:line:)` is called.
func assertAndLog(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
    if !condition() {
        let actualMessage = message()
        
        var addresses = Thread.callStackReturnAddresses
        addresses.removeFirst()
        
        let frames = addresses.map { CLSStackFrame(address: $0.uintValue) }
        
        Crashlytics.sharedInstance().recordCustomExceptionName("Assertion Failure", reason: actualMessage, frameArray: frames)
        
        assertionFailure(actualMessage, file: file, line: line)
    }
}

/// Logs a fatal error to Crashlytics, before causing a fatal error.
///
/// - Parameter message: The message of the fatal error.
func logFatalError(message: String, file: StaticString = #file, line: UInt = #line) -> Never {
    var addresses = Thread.callStackReturnAddresses
    addresses.removeFirst()
    
    let frames = addresses.map { CLSStackFrame(address: $0.uintValue) }
    
    Crashlytics.sharedInstance().recordCustomExceptionName("Fatal Error", reason: message, frameArray: frames)
    
    fatalError(message, file: file, line: line)
}
