//
//  DetailedFoodEntryView.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import SwiftUI

struct DetailedFoodEntryView: View {
    
    @EnvironmentObject var viewModel: FoodJournalViewModel
    @State private var foodEntry: FoodEntry
    
    @State private var foodName: String
    @State private var calories: String
    @State private var nutritionalSummary: String
    
    init(foodEntry: FoodEntry) {
        self._foodEntry = State(initialValue: foodEntry)
        self._foodName = State(initialValue: foodEntry.name)
        self._calories = State(initialValue: String(foodEntry.calories))
        self._nutritionalSummary = State(initialValue: "This is a healthy food rich in vitamins and low in fats.")
    }
    
    var body: some View {
        VStack {
            if let image = viewModel.loadImage(for: foodEntry) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300)
                    .padding()
            }
            
            Form {
                Section(header: Text("Food Details")) {
                    TextField("Food Name", text: $foodName)
                    TextField("Calories", text: $calories)
                        .keyboardType(.numberPad)
                }
                
                Text(nutritionalSummary)
                    .padding()
                
                Button(action: saveEntry) {
                    Text("Save Entry")
                }
                
                Button(action: deleteEntry) {
                    Text("Delete Entry")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Food Details")
        .padding()
    }
    
    func saveEntry() {
        guard let caloriesInt = Int(calories) else {
            // Show an alert that the calories value is invalid
            return
        }
        
        foodEntry.name = foodName
        foodEntry.calories = caloriesInt
        foodEntry.date = Date()
        foodEntry.imagePath = viewModel.saveImageToDocuments(image: viewModel.loadImage(for: foodEntry))
        
        do {
            viewModel.modelContext.insert(foodEntry)
            //Save the context if needed
            try viewModel.modelContext.save()
        } catch {
            print("Failed to save entry: \(error)")
        }
    }
    
    func deleteEntry() {
        viewModel.deleteEntry(foodEntry)
    }
}





////
////  DetailedFoodEntryView.swift
////  FlavorVista
////
////  Created by Asad Sayeed on 18/05/24.
////
//
//import SwiftUI
//
//struct DetailedFoodEntryView: View {
//    @EnvironmentObject var viewModel: FoodJournalViewModel
//    @State private var foodEntry: FoodEntry
//
//    @State private var foodName: String
//    @State private var calories: String
//    @State private var nutritionalSummary: String
//
//    init(foodEntry: FoodEntry) {
//        self._foodEntry = State(initialValue: foodEntry)
//        self._foodName = State(initialValue: foodEntry.name)
//        self._calories = State(initialValue: String(foodEntry.calories))
//        self._nutritionalSummary = State(initialValue: "This is a healthy food rich in vitamins and low in fats.")
//    }
//
//    var body: some View {
//        VStack {
//            if let image = viewModel.loadImage(for: foodEntry) {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxHeight: 300)
//                    .padding()
//            }
//
//            Form {
//                Section(header: Text("Food Details")) {
//                    TextField("Food Name", text: $foodName)
//                    TextField("Calories", text: $calories)
//                        .keyboardType(.numberPad)
//                }
//
//                Text(nutritionalSummary)
//                    .padding()
//
//                Button(action: saveEntry) {
//                    Text("Save Entry")
//                }
//
//                Button(action: deleteEntry) {
//                    Text("Delete Entry")
//                        .foregroundColor(.red)
//                }
//            }
//        }
//        .navigationTitle("Food Details")
//        .padding()
//    }
//
//    func saveEntry() {
//        guard let caloriesInt = Int(calories) else {
//            // Show an alert that the calories value is invalid
//            return
//        }
//
//        foodEntry.name = foodName
//        foodEntry.calories = caloriesInt
//        foodEntry.date = Date()
//        foodEntry.imagePath = viewModel.saveImageToDocuments(image: viewModel.loadImage(for: foodEntry))
//
//        do {
//            try viewModel.modelContext.save(foodEntry)
//        } catch {
//            print("Failed to save entry: \(error)")
//        }
//    }
//
//    func deleteEntry() {
//        viewModel.deleteEntry(foodEntry)
//    }
//}
