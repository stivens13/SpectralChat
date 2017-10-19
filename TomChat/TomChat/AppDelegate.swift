//
//  AppDelegate.swift
//  TomChat
//
//  Created by John Mai on 10/19/17.
//  Copyright © 2017 Silicon Spectra. All rights reserved.
//

import Cocoa
import Firebase
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        FirebaseApp.configure()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

