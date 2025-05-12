
import SwiftUI
import Charts

struct AIAnalyticsScreen: View {
    
    @EnvironmentObject var viewModel: FoodJournalViewModel
    @State private var showAverage = false
    
    var body: some View {
        VStack {
            Chart {
                ForEach(viewModel.foodEntries) { entry in
                    BarMark(
                        x: .value("Food", entry.name),
                        y: .value("Calories", entry.calories)
                    )
                    .foregroundStyle(by: .value("Food", entry.name))
                }
                if showAverage {
                    let averageCalories = viewModel.foodEntries.map { $0.calories }.reduce(0, +) / max(viewModel.foodEntries.count, 1)
                    RuleMark(y: .value("Average", averageCalories))
                        .foregroundStyle(Color.red)
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                        .annotation(position: .top, alignment: .leading) {
                            Text("average \(averageCalories)")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                }
            }
            .frame(height: 300)
            .padding()
            
            Toggle(isOn: $showAverage) {
                Text(showAverage ? "Hide Average" : "Show Average")
            }
            .padding()
        }
        .navigationTitle("Analytics")
    }
}

#Preview {
    AIAnalyticsScreen()
        .environmentObject(FoodJournalViewModel())
}

// Commented Code

////
////  AIAnalyticsView.swift
////  FlavorVista AI
////
////  Created by Asad Sayeed on 01/05/24.
////
//
//import SwiftUI
//import Charts
//
//struct AIAnalyticsView: View {
//    @ObservedObject var viewModel = AnalyticsViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                Text("AI Analytics")
//                    .font(.largeTitle)
//                    .padding()
//
//                PieChartView(entries: viewModel.pieChartEntries)
//                    .frame(height: 300)
//                    .padding()
//
//                BarChartView(entries: viewModel.barChartEntries)
//                    .frame(height: 300)
//                    .padding()
//
//                Text("Nutritional Summary")
//                    .font(.headline)
//                    .padding([.top, .leading, .trailing])
//
//                Text(viewModel.nutritionalSummary)
//                    .padding([.leading, .trailing, .bottom])
//
//                Text("Advice")
//                    .font(.headline)
//                    .padding([.top, .leading, .trailing])
//
//                Text(viewModel.advice)
//                    .padding([.leading, .trailing, .bottom])
//            }
//        }
//        .onAppear {
//            viewModel.fetchAnalyticsData()
//        }
//    }
//}
//
//struct AIAnalyticsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AIAnalyticsView()
//    }
//}


//
//  AIAnalyticsView.swift
//  FlavorVista AI
//
//  Created by Asad Sayeed on 01/05/24.
//

//import SwiftUI
//
//struct AIAnalyticsView: View {
//    var body: some View {
//        Text("This is the Analytics view")
//    }
//}
//
//#Preview {
//    AIAnalyticsView()
//}
