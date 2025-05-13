//
//  ContentView.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0  // 0 = FoodJournal, etc.
    @EnvironmentObject var viewModel: FoodJournalViewModel
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                FoodJournalScreen()
                    .tabItem {
                        Label("Food Journal", systemImage: "fork.knife")
                    }
                    .tag(0)
                
                AIAnalyticsScreen()
                    .tabItem {
                        Label("AI Analytics", systemImage: "wand.and.stars")
                    }
                    .tag(1)
                
                // Pass the binding to CameraView.
                CameraScreen(selectedTab: $selectedTab)
                    .tabItem {
                        Label("Camera", systemImage: "camera.viewfinder")
                    }
                    .tag(2)
                
                NutriExpertScreen()
                    .tabItem {
                        Label("Nutri Expert 24/7", systemImage: "star.bubble")
                    }
                    .tag(3)
                
                ProfileScreen()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(4)
            }
            .tint(.orange)
        }
    }
}

#Preview {
    TabBarView()
}
