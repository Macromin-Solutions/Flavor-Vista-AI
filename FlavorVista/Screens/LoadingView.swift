//
//  LoadingView.swift
//  FlavorVista
//
//  Created by Rahaf ALDossari on 05/01/1447 AH.
//


import SwiftUI

struct LoadingView: View {
    @State private var isLoadingComplete = false
    
    var body: some View {
        if isLoadingComplete {
            SignUpScreen()
                .transition(.opacity)
        } else {
            VStack {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isLoadingComplete = true
                    }
                }
            }
        }
    }
}




#Preview {
    LoadingView()
}
