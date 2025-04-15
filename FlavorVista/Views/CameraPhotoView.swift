import SwiftUI

struct CapturedPhotoView: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @Environment(\.dismiss) var dismiss
    @State private var foodName: String = ""
    @State private var calories: String = ""
    @State private var isSummaryGenerated: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let image = cameraViewModel.capturedImage {
                    VStack {
                        if cameraViewModel.isProcessing {
                            HStack {
                                ProgressView()
                                Text("Processing image...")
                                    .font(.headline)
                                    .padding(2)
                            }
                        } else {
                            // Title with capsule background and border
                            Text("Food Intelligence Summary 🥕")
                                .font(.title3)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(.ultraThickMaterial)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                            
                            // Nutritional summary area with blur effect before generation
                            ZStack {
                                HStack {
                                    Text(cameraViewModel.nutritionalSummary)
                                        .font(.headline)
                                        .padding()
                                }
                                .frame(minHeight: 150, maxHeight: 250)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.orange.gradient, lineWidth: 2)
                                )
                                .blur(radius: isSummaryGenerated ? 0 : 5)
                                .animation(.easeInOut, value: isSummaryGenerated)
                                
                                if !isSummaryGenerated {
                                    Button(action: {
                                        // Your summary generation logic
                                        isSummaryGenerated = true
                                    }) {
                                        HStack {
                                            Text("Generate Summary & Auto fill food details")
                                                .font(.caption)
                                            Image(systemName: "wand.and.stars")
                                        }
                                        .padding()
                                        .background(.ultraThickMaterial)
                                        .clipShape(Capsule())
                                        .shadow(radius: 5)
                                    }
                                }
                            }
                            .padding()
                            
                            // Display the captured and reference images
                            HStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(10)
                                    .frame(maxWidth: 300, maxHeight: 300)
                                
                                Image("foodmeal")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(maxWidth: 150)
                                    .alignmentGuide(VerticalAlignment.top) { $0[VerticalAlignment.center] }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.orange.gradient, lineWidth: 2)
                            )
                            .padding()
                            
                            // Custom styled input fields for food details
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Food Details")
                                    .font(.headline)
                                
                                TextField("Food Name", text: $foodName)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .onAppear {
                                        self.foodName = cameraViewModel.foodName
                                    }
                                
                                TextField("Calories", text: $calories)
                                    .keyboardType(.numberPad)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .onAppear {
                                        self.calories = String(cameraViewModel.calories)
                                    }
                            }
                            .padding(.horizontal)
                            
                            // Pill-shaped glass design Save button
                            Button(action: {
                                saveEntry()
                                dismiss()
                            }) {
                                Text("Save Entry")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .background(
                                        Color.white.opacity(0.2)
                                            .blur(radius: 10)
                                    )
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.white.opacity(0.7), lineWidth: 1)
                                    )
                                    .shadow(radius: 5)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 20)
                        }
                    }
                } else {
                    Text("No photo captured")
                        .font(.title)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func saveEntry() {
        guard let caloriesInt = Int(calories) else { return }
        let newEntry = FoodEntry(
            name: foodName,
            calories: caloriesInt,
            date: Date(),
            imagePath: saveImageToDocuments(image: cameraViewModel.capturedImage)
        )
        do {
            cameraViewModel.modelContext.insert(newEntry)
            cameraViewModel.foodEntries.append(newEntry)
            try cameraViewModel.modelContext.save()
        } catch {
            print("Failed to save entry: \(error)")
        }
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
