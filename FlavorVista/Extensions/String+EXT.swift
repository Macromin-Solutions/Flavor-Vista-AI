//
//  String+EXT.swift
//  FlavorVista
//
//  Created by Abdulkarim Koshak on 5/23/25.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
