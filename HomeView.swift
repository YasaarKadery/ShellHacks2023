//
//  HomeView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Drive", systemImage: "steeringwheel")
                }
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                        
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
