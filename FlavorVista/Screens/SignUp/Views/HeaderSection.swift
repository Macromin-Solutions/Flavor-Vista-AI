//
//  HeaderSection.swift
//  FlavorVista
//
//  Created by Ahmad Dannah on 22/11/1446 AH.
//

import SwiftUI

struct HeaderSection: View {
    
    private var title: String
    private var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.flavorVista(fontStyle: .title2))
                    .foregroundStyle(.grayscale100)
                
                Text(subtitle)
                    .font(.flavorVista(fontStyle: .body))
                    .foregroundStyle(.grayscale100)
            }
            Spacer()
        }
        .padding(.top, 20)
    }
}

#Preview {
    HeaderSection(title: "Title",
                  subtitle: "Subtitle")
    .background(Color.black)
}
