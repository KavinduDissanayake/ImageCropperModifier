//
//  ContentView.swift
//  ImageCropperModifierExample
//
//  Created by KavinduDissanayake on 2024-11-10.
//

import SwiftUI

// MARK: - Main Content View
struct ContentView: View {
    @State private var croppedImage: UIImage?

    var body: some View {
        VStack(spacing: 20) {
            // Header Text
            Text("Select Profile Picture")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(15)
                .padding(.horizontal)
            .imageCropperModifier(croppedImage: $croppedImage)

            // Display Cropped Image (if available)
            if let croppedImage = croppedImage {
                VStack(spacing: 15) {
                    Image(uiImage: croppedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 5)
                        .transition(.scale)

                    // Upload Button
                    Button(action: uploadProfilePicture) {
                        Text("Upload Profile Picture")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 40)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.top)
                }
                .animation(.easeInOut, value: croppedImage)
            } else {
                // Placeholder if no image is selected
                Text("No image selected")
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            }
        }
        .padding()
        .navigationTitle("Profile Picture Selector")
    }

    // MARK: - Upload Profile Picture Function
    private func uploadProfilePicture() {
        if let imageData = croppedImage?.jpegData(compressionQuality: 0.5) {
            let base64String = imageData.base64EncodedString()
            print("Base64 Encoded String: \(base64String)")
            // Implement the upload functionality here
        }
    }
}


#Preview {
    ContentView()
}
