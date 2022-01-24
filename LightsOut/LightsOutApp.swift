//
//  LightsOutApp.swift
//  LightsOut
//
//  Created by Arthur Ford on 1/22/22.
//

import SwiftUI

@main
struct LightsOutApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
