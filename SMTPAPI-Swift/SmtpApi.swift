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
    func addTo(address: String, name: String?) -> SmtpApi {
        if self.to == nil {
            self.to = []
        }
        var entry = address
        if let toName = name {
            entry = "\(toName) <\(address)>"
        }
        self.to!.append(entry)
        return self
    }
    
    func addTos(addresses: [String], names: [String]?) -> SmtpApi {
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
                return self
            }
        } else {
            self.to! += addresses
        }
        return self
    }
    
    func setTos(addresses: [String], names: [String]?) -> SmtpApi {
        self.to = []
        return self.addTos(addresses, names: names)
    }
    
    // MARK: BUILDER
    //=========================================================================
    
    
}