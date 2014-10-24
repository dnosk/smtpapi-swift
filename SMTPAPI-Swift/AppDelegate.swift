//
//  AppDelegate.swift
//  SMTPAPI-Swift
//
//  Created by Scott Kawai on 10/23/14.
//  Copyright (c) 2014 SendGrid. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        var header = SmtpApi()
        header.setTos(["scott@sendgrid.com","ron@sendgrid.com"], names: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

