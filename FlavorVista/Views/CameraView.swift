//
//  CameraView.swift
//  FlavorVista AI
//
//  Created by Asad Sayeed on 01/05/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    // Accept the selected tab binding from ContentView.
    @Binding var selectedTab: Int
    @StateObject private var cameraViewModel = CameraViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fullscreen camera preview.
                CameraPreview(session: cameraViewModel.session)
                    .ignoresSafeArea()
                    .onAppear {
                        cameraViewModel.configure()
                    }
                    // Stop the session when this view disappears.
                    .onDisappear {
                        cameraViewModel.stopSession()
                    }
                
                // Overlay UI elements.
                VStack {
                    // Top bar with only the 'x' (dismiss) button.
                    HStack {
                        Button(action: {
                            // Stop the camera and switch to Food Journal view (tag 0)
                            cameraViewModel.stopSession()
                            selectedTab = 0
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // Shutter button at the bottom.
                    Button(action: {
                        cameraViewModel.capturePhoto()
                    }) {
                        ZStack {
                            // Outer circle border.
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 80, height: 80)
                            // Inner filled circle.
                            Circle()
                                .fill(Color.white)
                                .frame(width: 65, height: 65)
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
            // Optionally, if an image has been captured, show a “View Captured Photo” button.
            .overlay(
                Group {
                    if cameraViewModel.capturedImage != nil {
                        NavigationLink(destination: CapturedPhotoView().environmentObject(cameraViewModel)) {
                            Text("View Captured Photo")
                                .font(.headline)
                                .padding()
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 100)
                    }
                },
                alignment: .bottom
            )
        }
        .environmentObject(cameraViewModel)
    }
}
