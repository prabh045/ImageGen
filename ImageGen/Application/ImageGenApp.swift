//
//  ImageGenApp.swift
//  ImageGen
//
//  Created by Prabhdeep Singh on 20/08/26.
//

import SwiftUI

@main
struct ImageGenApp: App {
    @State private var appManager = AppManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appManager)
        }
        .commands {
            CommandMenu("Action") {
                ImageButtonsView(displayForMenu: true)
                    .environment(appManager)
            }
        }
    }
}
