//
//  AppDelegate.swift
//  MenuBarPing
//
//  Created by Edouard Courty on 21/07/2020.
//  Copyright © 2020 Edouard Courty. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var popover: NSPopover!
    var statusBarItem: NSStatusItem!
    var ping: Float!
    static var HOST: String = "riot.de"
    var PING_DELAY: Double = 1.2
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 600, height: 500)
        popover.behavior = .transient
        self.popover = popover
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.title = "- ms"
            button.action = #selector(togglePopover(_:))
        }
        
        // Ping indefinitely
        let pinger = try? SwiftyPing(host: AppDelegate.HOST, configuration: PingConfiguration(interval: self.PING_DELAY, with: 5), queue: DispatchQueue.global())
        pinger?.observer = { (response) in
            let duration = response.duration * 1000
            let durationString: String = String(format: "%.0f ms", round(duration))
            self.statusBarItem.button?.title = durationString
        }
        pinger?.startPinging()
        
        buildMenu()
    }
    
    @objc func togglePopover(_ sender: AnyObject?) -> Void {
        if let button = self.statusBarItem.button {
            if self.popover.isShown {
                self.popover.performClose(sender)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
        
    func buildMenu() -> Void {
        let menu = NSMenu()

        menu.addItem(NSMenuItem(title: "Host: " + AppDelegate.HOST, action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit LoLPing", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        self.statusBarItem.menu = menu
    }

}
