//
//  AppDelegate.swift
//  MTMR
//
//  Created by Anton Palgunov on 16/03/2018.
//  Copyright © 2018 Anton Palgunov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        TouchBarController.shared.setupControlStripPresence()
        
        if let button = statusItem.button {
            button.image = #imageLiteral(resourceName: "StatusImage")
        }
        createMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func openPrefereces(_ sender: Any?) {
        let task = Process()
        let appSupportDirectory = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!.appending("/MTMR")
        let presetPath = appSupportDirectory.appending("/items.json")
        task.launchPath = "/usr/bin/open"
        task.arguments = [presetPath]
        task.launch()
    }
    
    @objc func updatePreset(_ sender: Any?) {
        TouchBarController.shared.createAndUpdatePreset()
    }
    
    @objc func openPreset(_ sender: Any?) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a items.json file"
        dialog.showsResizeIndicator    = true
        dialog.showsHiddenFiles        = true
        dialog.canChooseDirectories    = false
        dialog.canCreateDirectories    = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes        = ["json"]
        dialog.directoryURL = NSURL.fileURL(withPath: NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!.appending("/MTMR"), isDirectory: true)
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if (result != nil) {
                let path = result!.path
                let jsonData = path.fileData
                let jsonItems = jsonData?.barItemDefinitions() ?? [BarItemDefinition(type: .staticButton(title: "bad preset"), action: .none, additionalParameters: [:])]
                
                TouchBarController.shared.createAndUpdatePreset(jsonItems: jsonItems)
            }
        }
    }
    
    func createMenu() {
        let menu = NSMenu()
        menu.addItem(withTitle: "Preferences", action: #selector(openPrefereces(_:)), keyEquivalent: ",")
        menu.addItem(withTitle: "Reload Preset", action: #selector(updatePreset(_:)), keyEquivalent: "r")
        menu.addItem(withTitle: "Open Preset", action: #selector(openPreset(_:)), keyEquivalent: "O")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        statusItem.menu = menu
    }

}

