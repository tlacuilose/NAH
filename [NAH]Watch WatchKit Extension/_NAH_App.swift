//
//  _NAH_App.swift
//  [NAH]Watch WatchKit Extension
//
//  Created by Jose Tlacuilo on 18/05/21.
//

import SwiftUI

@main
struct _NAH_App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
