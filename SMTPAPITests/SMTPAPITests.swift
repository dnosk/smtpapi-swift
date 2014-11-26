//
//  SMTPAPI_SwiftTests.swift
//  SMTPAPI-SwiftTests
//
//  Created by Scott Kawai on 10/23/14.
//  Copyright (c) 2014 SendGrid. All rights reserved.
//

import XCTest
import Cocoa

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
    
    func testAddSection() {
        var header = SmtpApi()
        header.addSection("-greetMale-", value: "Hello Mr. %name%")
        XCTAssertEqual(header.jsonValue, "{\"section\":{\"-greetMale-\":\"Hello Mr. %name%\"}}", "Adds a section tag.")
    }
    
    func testAddUniqueArgument() {
        var header = SmtpApi()
        header.addUniqueArgument("foo", value: "bar")
        XCTAssertEqual(header.jsonValue, "{\"unique_args\":{\"foo\":\"bar\"}}", "Adds a unique argument")
    }
    
    func testAddCategory() {
        var header = SmtpApi()
        header.addCategory("Transactional")
        XCTAssertEqual(header.jsonValue, "{\"category\":[\"Transactional\"]}", "Adds one category")
        
        header.addCategory("Forgot Password")
        XCTAssertEqual(header.jsonValue, "{\"category\":[\"Transactional\",\"Forgot Password\"]}", "Adds two categories")
    }
    
    func testAddCategories() {
        var header = SmtpApi()
        header.addCategories(["Transactional", "Forgot Password"])
        XCTAssertEqual(header.jsonValue, "{\"category\":[\"Transactional\",\"Forgot Password\"]}", "Adds multiple categories")
    }
    
    func testAddFilter() {
        var header = SmtpApi()
        header.addFilter(SendGridFilter.OpenTracking, setting: "enable", value: 0)
        XCTAssertEqual(header.jsonValue, "{\"filters\":{\"opentrack\":{\"settings\":{\"enable\":0}}}}", "Adds filter settings")
    }
    
    func testSetSendAt() {
        var header = SmtpApi()
        var date = NSDate(timeIntervalSinceNow: (3 * 60 * 60)) // 3 hours from now
        header.setSendAt(date)
        XCTAssertEqual(header.jsonValue, "{\"send_at\":\(Int(date.timeIntervalSince1970))}", "Sets a scheduled time.")
    }
    
    func testSetSendEachAt() {
        var header = SmtpApi()
        var date1 = NSDate(timeIntervalSinceNow: (2 * 60 * 60))
        var date2 = NSDate(timeIntervalSinceNow: (5 * 60 * 60))
        header.setSendEachAt([date1, date2])
        XCTAssertEqual(header.jsonValue, "{\"send_each_at\":[\(Int(date1.timeIntervalSince1970)),\(Int(date2.timeIntervalSince1970))]}", "Sets an array of scheduled times.")
    }
    
    func testSetAsmGroup() {
        var header = SmtpApi()
        header.setAsmGroup(2)
        XCTAssertEqual(header.jsonValue, "{\"asm_group_id\":2}", "Sets an ASM group.")
    }
    
    func testHasSmtpApiProperty() {
        var header = SmtpApi()
        XCTAssertFalse(header.hasSmtpApi, "Initiating a new instance has `hasSmtpApi` equaling false.")
        header.setAsmGroup(2)
        XCTAssertTrue(header.hasSmtpApi, "Adding to the header makes `hasSmtpApi` equal true.")
    }
    
    func testIpPool() {
        var header = SmtpApi()
        header.setIpPool("pool_party")
        XCTAssertEqual(header.jsonValue, "{\"ip_pool\":\"pool_party\"}", "Sets an IP Pool.")
    }
    
}
