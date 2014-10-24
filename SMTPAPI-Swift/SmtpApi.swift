//
//  SmtpApi.swift
//  SMTPAPI-Swift
//
//  Created by Scott Kawai on 10/23/14.
//  Copyright (c) 2014 SendGrid. All rights reserved.
//

import Foundation

class SmtpApi {
    
    // MARK: PROPERTIES
    //=========================================================================
    var to: [String]?
    var sub: [String:[String]]?
    var section: [String:String]?
    var category: [String]?
    var unique_args: [String:String]?
    var filters: [String:AnyObject]?
    var send_at: Int?
    var send_each_at: [Int]?
    var asm_group_id: Int?
    
    // MARK: COMPUTED PROPERTIES
    //=========================================================================
    var dictionaryValue: [String:AnyObject] {
        var dictionary: [String:AnyObject] = [:]
        
        if let tos = self.to {
            dictionary["to"] = tos
        }
        
        if let subs = self.sub {
            dictionary["sub"] = subs
        }
        
        if let sections = self.section {
            dictionary["section"] = sections
        }
        
        if let args = self.unique_args {
            dictionary["unique_args"] = args
        }
        
        if let categories = self.category {
            dictionary["category"] = categories
        }
        
        if let filters = self.filters {
            dictionary["filters"] = filters
        }
        
        if let sendAt = self.send_at {
            dictionary["send_at"] = sendAt
        }
        
        if let sendEachAt = self.send_each_at {
            dictionary["send_each_at"] = sendEachAt
        }
        
        if let asm = self.asm_group_id {
            dictionary["asm_group_id"] = asm
        }
        
        return dictionary
    }
    
    var jsonValue: String {
        var dictionary = self.dictionaryValue
        var error: NSError?
        var data = NSJSONSerialization.dataWithJSONObject(dictionary, options: nil, error: &error)
        if let err = error {
            println("[**ERROR**] SmtpApi jsonValue: Error converting to JSON string. \(err.localizedDescription)")
        } else if let json = data {
            if let str = NSString(data: json, encoding: NSUTF8StringEncoding) {
                return str
            }
        } else {
            println("[**ERROR**] SmtpApi jsonValue: NSJSONSerialization returned nil from SmtpApi value.")
        }
        return "{}"
    }
    
    
    // MARK: INITIALIZATION
    //=========================================================================
    init() {}
    
    
    // MARK: FUNCTIONS
    //=========================================================================
    
    /* addTo(_:name:)
    *
    * SUMMARY
    * Appends an email address to the `to` property. Allows an optional to name
    * to be specified.
    *
    * PARAMETERS
    * address       A string of the email address to add.
    * name          An optional string of the recipient's name.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func addTo(address: String, name: String?) {
        if self.to == nil {
            self.to = []
        }
        var entry = address
        if let toName = name {
            entry = "\(toName) <\(address)>"
        }
        self.to!.append(entry)
    }
    
    /* addTos(_:names:)
    *
    * SUMMARY
    * Appends an array of email addresses to the `to` property. Allows an
    * optional array of to names to be specified.
    *
    * PARAMETERS
    * addresses     An array of strings representing the email addresses to add.
    * names         An optional array of strings representing the names of the
    *               recipients.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func addTos(addresses: [String], names: [String]?) {
        if self.to == nil {
            self.to = []
        }
        
        if let toNames = names {
            if countElements(addresses) == countElements(toNames) {
                for (index, name) in enumerate(toNames) {
                    var email = addresses[index]
                    self.to!.append("\(name) <\(email)>")
                }
            } else {
                println("[**ERROR**] SmtpApi addTos: The number of email addresses provided didn't match the number of names provided.")
                return
            }
        } else {
            self.to! += addresses
        }
    }
    
    /* setTos(_:names:)
    *
    * SUMMARY
    * Resets the `to` property to the passed array of email addresses. Allows
    * an optional array of to names to be specified.
    *
    * PARAMETERS
    * addresses     An array of strings representing the email addresses to 
    *               reset the `to` property to.
    * names         An optional array of strings representing the names of the
    *               recipients.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func setTos(addresses: [String], names: [String]?) {
        self.to = []
        self.addTos(addresses, names: names)
    }
    
    /* addSubstitution(_:values:)
    *
    * SUMMARY
    * Adds the array of values for the given key to the `sub` property.
    *
    * PARAMETERS
    * key       A string of the substitution tag.
    * values    An array of strings representing the substitution values.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func addSubstitution(key: String, values: [String]) {
        if self.sub == nil {
            self.sub = [:]
        }
        
        self.sub![key] = values
    }
    
    /* addSection(_:value:)
    *
    * SUMMARY
    * Adds a section tag and value.
    *
    * PARAMETERS
    * key       A string representing th key to be replaced.
    * value     A string representing the value to replace the key with.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func addSection(key: String, value: String) {
        if self.section == nil {
            self.section = [:]
        }
        
        self.section![key] = value
    }
    
}