//
//  FoodJournalView.swift
//  FlavorVista AI
//
//  Created by Asad Sayeed on 01/05/24.
//

import SwiftUI

struct FoodJournalView: View {
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
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(viewModel.foodEntries) { entry in
                            NavigationLink(destination: DetailedFoodEntryView(foodEntry: entry).environmentObject(viewModel)) {
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
            .navigationTitle("FlavorVista")
            .onAppear {
                viewModel.loadEntries()
            }
        }
    }
    
    
}

#Preview {
    FoodJournalView()
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
