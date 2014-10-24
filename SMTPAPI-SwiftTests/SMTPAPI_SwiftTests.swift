//
//  SMTPAPI_SwiftTests.swift
//  SMTPAPI-SwiftTests
//
//  Created by Scott Kawai on 10/23/14.
//  Copyright (c) 2014 SendGrid. All rights reserved.
//

import Cocoa
import XCTest

class SMTPAPI_SwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddTo() {
        var header1 = SmtpApi()
        header1.addTo("foo@bar.com", name: nil)
        XCTAssertEqual(header1.jsonValue, "{\"to\":[\"foo@bar.com\"]}", "Adds a single address with no name.")
        var header2 = SmtpApi()
        header2.addTo("foo@bar.com", name: "Foo Bar")
        XCTAssertEqual(header2.jsonValue, "{\"to\":[\"Foo Bar <foo@bar.com>\"]}", "Adds a single address with a to name.")
    }
    
}
