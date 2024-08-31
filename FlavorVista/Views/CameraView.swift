//
//  CameraView.swift
//  FlavorVista AI
//
//  Created by Asad Sayeed on 01/05/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var cameraViewModel = CameraViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if cameraViewModel.capturedImage == nil {
                    CameraPreview(session: cameraViewModel.session)
                        .onAppear { cameraViewModel.configure() }
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        Button(action: { cameraViewModel.capturePhoto() }) {
                            Text("Capture Photo")
                                .font(.title)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        .padding(.bottom, 30)
                    }
                } else {
                    NavigationLink(destination: CapturedPhotoView().environmentObject(cameraViewModel)) {
                        Text("View Captured Photo")
                            .font(.title)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .environmentObject(cameraViewModel)
    }
}

#Preview {
    CameraView()
}
