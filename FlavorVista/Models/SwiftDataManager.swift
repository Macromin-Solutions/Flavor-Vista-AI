//
//  SwiftDataManager.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import Foundation
import SwiftData

class SwiftDataManager {
    
    static let shared = SwiftDataManager()
    
    let modelContainer: ModelContainer
    
    private init() {
        do {
            modelContainer = try ModelContainer(for: FoodEntry.self, UserProfile.self)
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }
}


////
////  SwiftDataManager.swift
////  FlavorVista
////
////  Created by Asad Sayeed on 18/05/24.
////
//
//import Foundation
//import SwiftData
//
//class SwiftDataManager {
//    static let shared = SwiftDataManager()
//    
//    let modelContainer: ModelContainer
//    
//    init() {
//        do {
//            modelContainer = try ModelContainer(for: FoodEntry.self)
//        } catch {
//            fatalError("Failed to create model container: \(error)")
//        }
//    }
//}
