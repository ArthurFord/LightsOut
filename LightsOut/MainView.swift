//
//  MainView.swift
//  LightsOut
//
//  Created by Arthur Ford on 1/23/22.
//

import SwiftUI

struct MainView: View {
    
    
    
    var body: some View {
        TabView {
            GameView()
            .tabItem {
                Label("Game", systemImage: "star")
            }
            RecordsView()
                .tabItem {
                    Label("Records", systemImage: "menubar.dock.rectangle.badge.record")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
