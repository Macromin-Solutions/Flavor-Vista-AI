//
//  FoodJournalViewModel.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class FoodJournalViewModel: ObservableObject {
    @Published var foodEntries: [FoodEntry] = []
    @Published var username: String = "User"
    @Published var streak: Int = 0
    
    let modelContext: ModelContext = SwiftDataManager.shared.modelContainer.mainContext
    
    init() {
        loadEntries()
    }
    
    func loadEntries() {
        let fetchDescriptor = FetchDescriptor<FoodEntry>()
        do {
            foodEntries = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch entries: \(error)")
        }
    }
    
    func saveEntry(_ entry: FoodEntry) {
        do {
            modelContext.insert(entry)
            try modelContext.save()
            loadEntries()
        } catch {
            print("Failed to save entry: \(error)")
        }
    }
    
    func deleteEntry(_ entry: FoodEntry) {
        do {
            modelContext.delete(entry)
            try modelContext.save()
            loadEntries()
        } catch {
            print("Failed to delete entry: \(error)")
        }
    }
    
    func loadImage(for entry: FoodEntry) -> UIImage? {
        guard let imagePath = entry.imagePath else { return nil }
        return ImageHelper.loadImage(forKey: imagePath)
    }
    
    func saveImageToDocuments(image: UIImage?) -> String? {
        guard let image = image, let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        let filename = UUID().uuidString
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(filename)
        do {
            try data.write(to: path)
            return path.lastPathComponent
        } catch {
            print("Failed to save image: \(error)")
            return nil
        }
    }
}





////
////  FoodJournalViewModel.swift
////  FlavorVista
////
////  Created by Asad Sayeed on 18/05/24.
////
//
//import Foundation
//import SwiftUI
//import SwiftData
//
//@MainActor
//class FoodJournalViewModel: ObservableObject {
//    @Published var foodEntries: [FoodEntry] = []
//    @Published var username: String = "User"
//    @Published var streak: Int = 0
//    
//    private let modelContext: ModelContext
//    
//    init() {
//        modelContext = SwiftDataManager.shared.modelContainer.mainContext
//        loadEntries()
//    }
//    
//    func loadEntries() {
//        let fetchDescriptor = FetchDescriptor<FoodEntry>()
//        do {
//            foodEntries = try modelContext.fetch(fetchDescriptor)
//        } catch {
//            print("Failed to fetch entries: \(error)")
//        }
//    }
//    
//    func saveEntry(_ entry: FoodEntry) {
//        modelContext.insert(entry)
//        do {
//            try modelContext.save()
//            loadEntries()
//        } catch {
//            print("Failed to save entry: \(error)")
//        }
//    }
//    
//    func addFoodEntry(name: String, calories: Int, date: Date, image: UIImage?) {
//        var imagePath: String? = nil
//        if let image = image {
//            let imageName = UUID().uuidString
//            if ImageHelper.saveImage(image: image, forKey: imageName) {
//                imagePath = imageName
//            }
//        }
//        
//        let newEntry = FoodEntry(name: name, calories: calories, date: date, imagePath: imagePath)
//        saveEntry(newEntry)
//    }
//    
//    func loadImage(for entry: FoodEntry) -> UIImage? {
//        guard let imagePath = entry.imagePath else { return nil }
//        return ImageHelper.loadImage(forKey: imagePath)
//    }
//}
