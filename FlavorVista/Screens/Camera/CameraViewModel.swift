//
//  CameraViewModel.swift
//  FlavorVista
//
//  Created by Asad Sayeed on 18/05/24.
//

import Foundation
import AVFoundation
import UIKit
import SwiftData

@MainActor
class CameraViewModel: NSObject, ObservableObject {
    
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    @Published var session: AVCaptureSession = AVCaptureSession()
    @Published var capturedImage: UIImage?
    @Published var foodName: String = ""
    @Published var calories: Int = 0
    @Published var nutritionalSummary: String = ""
    @Published var isProcessing: Bool = false
    @Published var foodEntries: [FoodEntry] = []
    private(set) var hasDeniedPermission: Bool = false
    @Published var showHasDeniedPermissionScreen: Bool = false

    let modelContext: ModelContext = SwiftDataManager.shared.modelContainer.mainContext
    
    func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            configure()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {

                    self.configure()
                }
            }
        default:
            print("Camera access denied or restricted.")
            hasDeniedPermission = true
            showHasDeniedPermissionScreen = true
        }
    }
    
    private func configure() {
        self.hasDeniedPermission = false
        self.showHasDeniedPermissionScreen = false

        sessionQueue.async {
            self.setupSession()
            self.session.startRunning()
        }
    }
    
    func stopSession() {
        sessionQueue.async {
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }
    
    private func setupSession() {
          session.beginConfiguration()
          guard let videoDevice = AVCaptureDevice.default(for: .video) else {
              print("No video device available — likely running on Simulator.")
              session.commitConfiguration()
              return
          }
          guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
                 session.commitConfiguration()
                 return
             }
          if session.canAddInput(videoDeviceInput) { session.addInput(videoDeviceInput) }
          let photoOutput = AVCapturePhotoOutput()
          if session.canAddOutput(photoOutput) { session.addOutput(photoOutput) }
          session.commitConfiguration()
        }

//         session.beginConfiguration()
//         guard let videoDevice = AVCaptureDevice.default(for: .video),
//               let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
//         if session.canAddInput(videoDeviceInput) {
//             session.addInput(videoDeviceInput)
//         }
//         let photoOutput = AVCapturePhotoOutput()
//         if session.canAddOutput(photoOutput) {
//             session.addOutput(photoOutput)
//         }
//         session.commitConfiguration()
//     }
    
    func capturePhoto() {
        guard let photoOutput = session.outputs.first as? AVCapturePhotoOutput else { return }
        let photoSettings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func processImageWithGPTVision(image: UIImage) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.foodName = "Example Food"
            self.calories = 200
            self.nutritionalSummary = "This is a healthy food rich in vitamins and low in fats."
            self.isProcessing = false
        }
    }
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error { print("Error capturing photo: \(error)") }
        guard let photoData = photo.fileDataRepresentation(),
              let image = UIImage(data: photoData) else { return }
        DispatchQueue.main.async {
            self.capturedImage = image
            self.isProcessing = true
            self.processImageWithGPTVision(image: image)
        }
    }
}
