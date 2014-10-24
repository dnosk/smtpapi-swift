//
//  SmtpApi.swift
//  SMTPAPI-Swift
//
//  Created by Scott Kawai on 10/23/14.
//  Copyright (c) 2014 SendGrid. All rights reserved.
//

import Foundation

enum SendGridFilter: String {
    case BCC = "bcc"
    case BypassListManagement = "bypass_list_management"
    case ClickTracking = "clicktrack"
    case DKIM = "dkim"
    case DomainKeys = "domainkeys"
    case Footer = "footer"
    case ForwardSpam = "forwardspam"
    case GoogleAnalytics = "ganalytics"
    case Gravatar = "gravatar"
    case OpenTracking = "opentrack"
    case SpamCheck = "spamcheck"
    case SubscriptionTracking = "subscriptiontrack"
    case LegacyTemplates = "template"
    case TemplateEngine = "templates"
}

class SmtpApi {
    
    // MARK: VERSION
    //=========================================================================
    class var version: String {
        return "0.0.1"
    }
    
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
        var error: NSError?
        var data = NSJSONSerialization.dataWithJSONObject(self.dictionaryValue, options: nil, error: &error)
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
        var names: [String]?
        if let n = name {
            names = [n]
        }
        self.addTos([address], names: names)
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
    
    /* addUniqueArgument(_:value:)
    *
    * SUMMARY
    * Adds a key-value pair to the unique arguments.
    *
    * PARAMETERS
    * key       A string for the unique argument key.
    * value     A string for the unique arugment value.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func addUniqueArgument(key: String, value: String) {
        if self.unique_args == nil {
            self.unique_args = [:]
        }
        
        self.unique_args![key] = value
    }
    
    /* addCategory(_:)
    *
    * SUMMARY
    * Adds a category to the category array.
    *
    * PARAMETERS
    * category      A string representing the category to add.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func addCategory(category: String) {
        self.addCategories([category])
    }
    
    /* addCategories(_:)
    *
    * SUMMARY
    * Appends an array of categories to the category property.
    *
    * PARAMETERS
    * categories    An array of categories to add.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func addCategories(categories: [String]) {
        if self.category == nil {
            self.category = []
        }
        
        self.category! += categories
    }
    
    /* addFilter(_:setting:value:)
    *
    * SUMMARY
    * Adds a value for a given setting for a given filter (app).
    *
    * PARAMETERS
    * filter    The filter to modify. Uses the SendGridFilter enum.
    * setting   The name of the setting
    * value     The value to set for the given setting.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func addFilter(filter: SendGridFilter, setting: String, value: Any) {
        if self.filters == nil {
            self.filters = [:]
        }
        
        if let apps = self.filters {
            var settings = [String:AnyObject]()
            if let app = apps[filter.rawValue] as? [String:AnyObject] {
                if let s = app["settings"] as? [String:AnyObject] {
                    settings = s
                }
            }
            
            if let val = value as? Int {
                settings[setting] = NSNumber(integer: val)
            } else if let val = value as? String {
                settings[setting] = val
            } else {
                println("[**ERROR**] SmtpApi addFilter: Only Strings and Integers are allowed as values.")
                return
            }
            
            var app: [String:AnyObject] = ["settings":settings]
            self.filters?[filter.rawValue] = app
        }
        
    }
    
    /* setSendAt(_:)
    *
    * SUMMARY
    * Sets the send_at property, which specifies a time to send the email at.
    *
    * PARAMETERS
    * date      An NSDate object representing when to send the message.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func setSendAt(date: NSDate) {
        self.verifyScheduleDate(date)
        
        self.send_at = Int(date.timeIntervalSince1970)
    }
    
    /* setSendEachAt(_:)
    *
    * SUMMARY
    * Sets a date to send each individual copy at (for each recipient).
    *
    * PARAMETERS
    * dates     An Array of NSDate objects indicating when to send the message.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func setSendEachAt(dates: [NSDate]) {
        if self.send_each_at == nil {
            self.send_each_at = []
        }
        
        for date in dates {
            self.verifyScheduleDate(date)
            self.send_each_at?.append(Int(date.timeIntervalSince1970))
        }
    }
    
    /* setAsmGroup(_:)
    *
    * SUMMARY
    * Assigns the email an Advanced Suppression Management group.
    *
    * PARAMETERS
    * id    The ID of the ASM group.
    *
    * RETURNS
    * Nothing.
    *
    *=========================================================================*/
    
    func setAsmGroup(id: Int) {
        self.asm_group_id = id
    }
    
    
    // MARK: CONVENIENCE FUNCTIONS
    //=========================================================================
    
    /* verifyScheduleDate(_:)
    *
    * SUMMARY
    * Verifies that the NSDate being used for scheduling is in the valid time
    * frame.
    *
    * PARAMETERS
    * date      An NSDate object representing when to send a message.
    *
    * RETURNS
    * A boolean, indicating if the date is valid or not.
    *
    *=========================================================================*/
    
    func verifyScheduleDate(date: NSDate) -> Bool {
        var valid = true
        var formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        var time = NSDateFormatter()
        time.timeStyle = NSDateFormatterStyle.LongStyle
        
        var now = NSDate()
        
        var scheduled = "\(formatter.stringFromDate(date)) at \(time.stringFromDate(date))"
        var current = "\(formatter.stringFromDate(now)) at \(time.stringFromDate(now))"
        
        if date.timeIntervalSinceNow <= 0 {
            println("[**WARNING**] SmtpApi setSendAt: Date \"\(scheduled)\" was set to a time in the past (currently it is \(current))")
            valid = false
        } else if date.timeIntervalSinceNow > (24 * 60 * 60) {
            println("[**WARNING**] SmtpApi setSendAt: Date \"\(scheduled)\" was set to unsupported time (further than 24 hours in the future - currently it is \(current)). See https://sendgrid.com/docs/API_Reference/SMTP_API/scheduling_parameters.html for more details.")
            valid = false
        }
        return valid
    }
    
}