//
//  FlavorVistaApp.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 20/05/24.
//

import SwiftUI
import Firebase


@main
struct FlavorVistaApp: App {
    @StateObject private var viewModel = FoodJournalViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
      if let firebase = FirebaseApp.app() {
          print(" configured firebase")
      } else {
          print("failed to configure firebase")
      }


    return true
  }
}

