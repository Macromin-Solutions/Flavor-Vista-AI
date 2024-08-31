//
//  ImageHelper.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import SwiftUI

struct ImageHelper {
    static func saveImage(image: UIImage, forKey key: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return false }
        let filename = getDocumentsDirectory().appendingPathComponent(key)
        
        do {
            try data.write(to: filename)
            return true
        } catch {
            print("Failed to save image: \(error.localizedDescription)")
            return false
        }
    }
    
    static func loadImage(forKey key: String) -> UIImage? {
        let filename = getDocumentsDirectory().appendingPathComponent(key)
        
        if let data = try? Data(contentsOf: filename) {
            return UIImage(data: data)
        }
        
        return nil
    }
    
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
