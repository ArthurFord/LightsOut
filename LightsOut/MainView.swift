//
//  MainView.swift
//  LightsOut
//
//  Created by Arthur Ford on 1/23/22.
//

import SwiftUI

struct MainView: View {

    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "darkestGray")
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    var body: some View {
        TabView {
            GameView()
            .tabItem {
                Label("Game", systemImage: "lightbulb.fill")
            }
            RecordsView()
                .tabItem {
                    Label("Records", systemImage: "list.dash")
                }
        }
        .accentColor(.orange)
        .onAppear(perform: BGMusic.shared.startBGMusic)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
