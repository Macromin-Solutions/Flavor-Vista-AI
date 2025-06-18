//
//  FoodJournalView.swift
//  FlavorVista AI
//
//  Created by Asad Sayeed on 01/05/24.
//

import SwiftUI

struct FoodJournalScreen: View {

    @Binding var selectedTab: Tab
    @StateObject private var viewModel = FoodJournalViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome, \(viewModel.username)")
                    .font(.largeTitle)
                    .padding()
                
                Text("Your streak: \(viewModel.streak) days")
                    .padding()
                
                Text("Total meals: \(viewModel.foodEntries.count)")
                    .padding()

                if viewModel.foodEntries.isEmpty {
                    Button(action: navigateToCameraView) {
                        Text("No meals logged? Start adding")
                            .foregroundColor(.red)
                    }
                } else {

                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(viewModel.foodEntries) { entry in
                                NavigationLink(destination: DetailedFoodEntryScreen(foodEntry: entry).environmentObject(viewModel)) {
                                    VStack {
                                        if let image = viewModel.loadImage(for: entry) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 150, height: 150)
                                                .clipped()
                                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                        }
                                        Text(entry.name)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("FlavorVista")
            .onAppear {
                viewModel.loadEntries()
            }
            
        }
    }

    func navigateToCameraView() {
        selectedTab = .camera
    }
}

#Preview {
    FoodJournalScreen(selectedTab: .constant(.foodJournal))
}




////
////  FoodJournalView.swift
////  FlavorVista AI
////
////  Created by Asad Sayeed on 01/05/24.
////
//
//import SwiftUI
//
//struct FoodJournalView: View {
//    @StateObject private var viewModel = FoodJournalViewModel()
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("Welcome, \(viewModel.username)")
//                    .font(.largeTitle)
//                    .padding()
//                
//                Text("Your streak: \(viewModel.streak) days")
//                    .padding()
//                
//                ScrollView {
//                    LazyVGrid(columns: [GridItem(), GridItem()]) {
//                        ForEach(viewModel.foodEntries) { entry in
//                            VStack {
//                                if let image = viewModel.loadImage(for: entry) {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 100, height: 100)
//                                        .clipped()
//                                }
//                                Text(entry.name)
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("FlavorVista")
//            .onAppear {
//                viewModel.loadEntries()
//            }
//        }
//    }
//}
//
//#Preview {
//    FoodJournalView()
//}
