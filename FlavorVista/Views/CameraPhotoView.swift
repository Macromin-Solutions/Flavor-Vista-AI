//
//  CapturedPhotoView.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import SwiftUI

struct CapturedPhotoView: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @State private var foodName: String = ""
    @State private var calories: String = ""

    var body: some View {
        VStack {
            if let image = cameraViewModel.capturedImage {
                VStack {
                    if cameraViewModel.isProcessing {
                        Text("Processing image...")
                            .font(.headline)
                            .padding()
                    } else {
                        Text(cameraViewModel.nutritionalSummary)
                            .font(.headline)
                            .padding()
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .padding()
                        
                        Form {
                            Section(header: Text("Food Details")) {
                                TextField("Food Name", text: $foodName)
                                    .onAppear { self.foodName = cameraViewModel.foodName }
                                TextField("Calories", text: $calories)
                                    .keyboardType(.numberPad)
                                    .onAppear { self.calories = String(cameraViewModel.calories) }
                            }
                            
                            Button(action: saveEntry) {
                                Text("Save Entry")
                            }
                        }
                        .padding()
                    }
                }
            } else {
                Text("No photo captured")
            }
        }
    }
    
    func saveEntry() {
        guard let caloriesInt = Int(calories) else { return }
        let newEntry = FoodEntry(name: foodName, calories: caloriesInt, date: Date(), imagePath: saveImageToDocuments(image: cameraViewModel.capturedImage))
        do {
            cameraViewModel.modelContext.insert(newEntry)
            cameraViewModel.foodEntries.append(newEntry)
            try cameraViewModel.modelContext.save()
        } catch { print("Failed to save entry: \(error)") }
        foodName = ""
        calories = ""
        cameraViewModel.capturedImage = nil
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
