//
//  FoodEntry.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import Foundation
import SwiftData

@Model
class FoodEntry: Identifiable {
    
    @Attribute(.unique) var id = UUID()
    var name: String
    var calories: Int
    var date: Date
    var imagePath: String?
    
    init(name: String, calories: Int, date: Date, imagePath: String? = nil) {
        self.name = name
        self.calories = calories
        self.date = date
        self.imagePath = imagePath
    }
}
