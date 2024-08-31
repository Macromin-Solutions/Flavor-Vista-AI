////
////  AIAnalyticsViewModel.swift
////  FlavorVista
////
////  Created by Asad Sayeed on 20/05/24.
////
//
//import SwiftUI
//import Combine
//
//class AnalyticsViewModel: ObservableObject {
//    @Published var pieChartEntries: [ChartDataEntry] = []
//    @Published var barChartEntries: [ChartDataEntry] = []
//    @Published var nutritionalSummary: String = ""
//    @Published var advice: String = ""
//    
//    private var cancellables = Set<AnyCancellable>()
//    private let apiKey = "your_api_key_here"
//    private let assistantId = "your_assistant_id_here"
//    private let baseURL = "https://ai-flavorvistaai766530959280.openai.azure.com"
//    
//    func fetchAnalyticsData() {
//        // Simulate fetching FoodEntry data
//        let foodEntries = fetchFoodEntries()
//        
//        // Process the data to create chart entries
//        self.pieChartEntries = processPieChartData(foodEntries: foodEntries)
//        self.barChartEntries = processBarChartData(foodEntries: foodEntries)
//        
//        // Fetch nutritional summary and advice
//        fetchNutritionalSummaryAndAdvice(foodEntries: foodEntries) { summary, advice in
//            DispatchQueue.main.async {
//                self.nutritionalSummary = summary
//                self.advice = advice
//            }
//        }
//    }
//    
//    private func fetchFoodEntries() -> [FoodEntry] {
//        // Replace with actual data fetching logic
//        return [
//            FoodEntry(name: "Apple", calories: 95, date: Date()),
//            FoodEntry(name: "Banana", calories: 105, date: Date()),
//            FoodEntry(name: "Bread", calories: 80, date: Date())
//        ]
//    }
//    
//    private func processPieChartData(foodEntries: [FoodEntry]) -> [ChartDataEntry] {
//        // Replace with actual pie chart data processing logic
//        return foodEntries.map { ChartDataEntry(category: $0.name, value: Double($0.calories)) }
//    }
//    
//    private func processBarChartData(foodEntries: [FoodEntry]) -> [ChartDataEntry] {
//        // Replace with actual bar chart data processing logic
//        return foodEntries.map { ChartDataEntry(category: $0.name, value: Double($0.calories)) }
//    }
//    
//    private func fetchNutritionalSummaryAndAdvice(foodEntries: [FoodEntry], completion: @escaping (String, String) -> Void) {
//        let url = URL(string: "\(baseURL)/openai/assistants/\(assistantId)/threads?api-version=2024-02-15-preview")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue(apiKey, forHTTPHeaderField: "api-key")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let body: [String: Any] = [
//            "role": "assistant",
//            "content": "Generate a nutritional summary and provide advice based on the user's food entry data: \(foodEntries)"
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error fetching summary and advice: \(error?.localizedDescription ?? "Unknown error")")
//                completion("No summary available.", "No advice available.")
//                return
//            }
//            
//            do {
//                let result = try JSONDecoder().decode(AssistantResponse.self, from: data)
//                let summary = result.messages.first?.content ?? "No summary available."
//                let advice = result.messages.last?.content ?? "No advice available."
//                completion(summary, advice)
//            } catch {
//                print("Error decoding summary and advice response: \(error.localizedDescription)")
//                completion("No summary available.", "No advice available.")
//            }
//        }.resume()
//    }
//}
//
//struct ChartDataEntry: Identifiable {
//    let id = UUID()
//    let category: String
//    let value: Double
//    var startAngle: Double = 0.0
//    var endAngle: Double = 0.0
//    var color: Color = .blue
//}
