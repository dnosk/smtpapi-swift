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
        var header = SmtpApi()
        header.addTo("foo@bar.com", name: nil)
        XCTAssertEqual(header.jsonValue, "{\"to\":[\"foo@bar.com\"]}", "Adds a single address with no name.")
        
        header.addTo("foo@bar.com", name: "Foo Bar")
        XCTAssertEqual(header.jsonValue, "{\"to\":[\"foo@bar.com\",\"Foo Bar <foo@bar.com>\"]}", "Adds a single address with a to name.")
    }
    
    func testAddTos() {
        var header = SmtpApi()
        header.addTos(["foo@bar.com","bar@foo.com"], names: nil)
        XCTAssertEqual(header.jsonValue, "{\"to\":[\"foo@bar.com\",\"bar@foo.com\"]}", "Adds multiple addresses with no names.")
        
        header.addTos(["foo@bar.com","bar@foo.com"], names: ["Foo", "Bar"])
        XCTAssertEqual(header.jsonValue, "{\"to\":[\"foo@bar.com\",\"bar@foo.com\",\"Foo <foo@bar.com>\",\"Bar <bar@foo.com>\"]}", "Adds multiple addresses with  to names.")
    }
    
    func testSetTos() {
        var header = SmtpApi()
        header.setTos(["foo@bar.com"], names: nil)
        XCTAssertEqual(header.jsonValue, "{\"to\":[\"foo@bar.com\"]}", "Sets multiple addresses with no existing addresses and no to names.")
        
        header.setTos(["foo@bar.com","bar@foo.com"], names: nil)
        XCTAssertEqual(header.jsonValue, "{\"to\":[\"foo@bar.com\",\"bar@foo.com\"]}", "Sets multiple addresses with pre-existing addresses and no to names.")
        
        header.setTos(["foo@bar.com","bar@foo.com"], names: ["Foo", "Bar"])
        XCTAssertEqual(header.jsonValue, "{\"to\":[\"Foo <foo@bar.com>\",\"Bar <bar@foo.com>\"]}", "Sets multiple addresses with pre-existing addresses and to names.")
    }
    
    func testAddSubstitution() {
        var header = SmtpApi()
        header.addSubstitution("%name%", values: ["Isaac","Jose","Tim"])
        XCTAssertEqual(header.jsonValue, "{\"sub\":{\"%name%\":[\"Isaac\",\"Jose\",\"Tim\"]}}", "Adds substitution values.")
    }

    
}
