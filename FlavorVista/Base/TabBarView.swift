//
//  ContentView.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import SwiftUI

enum Tab {
    case foodJournal
    case aiAnalytics
    case camera
    case nutriChat
    case profile
}

struct TabBarView: View {
    
    @State private var selectedTab: Tab = .foodJournal   // 0 = FoodJournal, etc.
    @EnvironmentObject var viewModel: FoodJournalViewModel
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                FoodJournalScreen(selectedTab: $selectedTab)
                    .tabItem {
                        Label("Food Journal", systemImage: "fork.knife")
                    }
                    .tag(Tab.foodJournal)

                AIAnalyticsScreen()
                    .tabItem {
                        Label("AI Analytics", systemImage: "wand.and.stars")
                    }
                    .tag(Tab.aiAnalytics)

                // Pass the binding to CameraView.
                CameraScreen(selectedTab: $selectedTab)
                    .tabItem {
                        Label("Camera", systemImage: "camera.viewfinder")
                    }
                    .tag(Tab.camera)

                NutriExpertScreen()
                    .tabItem {
                        Label("Nutri Expert 24/7", systemImage: "star.bubble")
                    }
                    .tag(Tab.nutriChat)

                ProfileScreen()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(Tab.profile)
            }
            .tint(.orange)
        }
    }
}

#Preview {
    TabBarView()
}
