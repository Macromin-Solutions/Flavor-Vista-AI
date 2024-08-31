//
//  ContentView.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import SwiftUI

struct ContentView: View {
//    @State private var user = "User"
    @EnvironmentObject var viewModel: FoodJournalViewModel

    
    var body: some View {
        NavigationStack {
            
            HStack {
                //Last 6 days streak plus a circle that displays current log entry streak!
            }
            Spacer()
            
                
            TabView {
                FoodJournalView()
                    .tabItem {
                        Label("Food Journal", systemImage: "fork.knife")
                    }
                
                AIAnalyticsView()
                    .tabItem {
                        Label("AI Analytics", systemImage: "wand.and.stars")
                    }
                
                CameraView()
                    .tabItem {
                        Label("Camera", systemImage: "camera.viewfinder")
                    }
                
                NutriExpertView()
                    .tabItem {
                        Label("Nutri Expert 24/7", systemImage: "star.bubble")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .tint(.orange)
            
        }
    }
}

#Preview {
    ContentView()
}
