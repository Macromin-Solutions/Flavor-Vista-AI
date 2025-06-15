//
//  CameraPermissionDeniedScreen.swift
//  FlavorVista
//
//  Created by Geylan Kalaf Mohe on 08/06/2025.
//

import SwiftUI
import AVFoundation

/// A view shown when the app does not have permission to use the camera.
/// It explains the need for access and provides a button to open app settings.
struct CameraPermissionDeniedScreen: View {
    
    /// The currently selected tab in the parent view, used to redirect on denial.
    @Binding var selectedTab: Int
    
    /// Environment dismiss action to close the current view.
    @Environment(\.dismiss) var dismiss
    
    /// Shared camera view model for checking camera permission status.
    @EnvironmentObject private var cameraViewModel: CameraViewModel
    
    var body: some View {
        VStack {
            
            // MARK: - Close Button
            
            HStack {
                Spacer()
                Button {
                    checkPermissionAndDismiss()
                } label: {
                    Image(systemName: "xmark")
                        .padding()
                        .background(Color.black)
                        .foregroundStyle(.white)
                }
                .clipShape(Circle())
                .shadow(radius: 8)
            }
            .padding()
            
            Spacer()
            
            // MARK: - Permissions Message
            
            VStack(alignment: .center) {
                Image(systemName: "hand.raised.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 90))
                
                Text("Permissions required")
                    .font(.flavorVista(fontStyle: .title2))
                
                Text("To take photos or scan barcodes, access to the camera is needed")
                    .font(.flavorVista(fontStyle: .headline))
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // MARK: - Permission Status Indicator
            
            HStack {
                Image(systemName: "camera")
                    .padding()
                    .foregroundStyle(.orange)

                Text("Camera Permission")
                    .font(.flavorVista(fontStyle: .headline))
                
                Spacer()
                
                Image(systemName: "xmark.circle")
                    .padding()
                    .foregroundStyle(.orange)
            }
            .background(
                Rectangle()
                    .fill(Color(UIColor.systemBackground))
                    .cornerRadius(15)
                    .shadow(color: .primary.opacity(0.5), radius: 5)
            )
            .padding()
            
            Spacer()
            
            // MARK: - Open Settings Button
            
            Button {
                openAppSettings()
            } label: {
                Text("Continue")
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .font(.flavorVista(fontStyle: .title3))
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .padding()
        }
        .environmentObject(cameraViewModel)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // Called when the app comes back from background (e.g., after opening Settings).
            checkPermissionAndDismiss()
        }
    }
    
    /// Opens the system Settings app at this app's settings page.
    func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    /// Checks the current camera permission and dismisses the screen if allowed.
    /// If permission is still denied, sets the selected tab to default (e.g. Home).
    func checkPermissionAndDismiss() {
        cameraViewModel.checkCameraPermissions()
        
        if (cameraViewModel.hasDeniedPermission) {
            selectedTab = 0
        }
        
        dismiss()
    }
}

/// Preview for CameraPermissionDeniedScreen with a default selected tab binding.
#Preview {
    CameraPermissionDeniedScreen(selectedTab: .constant(0))
}
