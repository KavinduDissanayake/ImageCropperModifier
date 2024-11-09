//
//  ImagePickerButtonModifier.swift
//  ImageCropperModifierExample
//
//  Created by KavinduDissanayake on 2024-11-10.
//
import Mantis
import SwiftUI
// MARK: - Image Picker Button Modifier
struct ImagePickerButtonModifier: ViewModifier {
    @Binding var image: UIImage?
    @Binding var showImagePicker: Bool
    @State private var showActionSheet = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                showActionSheet.toggle()
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Select Photo"),
                    buttons: [
                        .default(Text("Photo Library")) {
                            showImagePicker = true
                            sourceType = .photoLibrary
                        },
                        .default(Text("Camera")) {
                            showImagePicker = true
                            sourceType = .camera
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image, isShown: $showImagePicker, sourceType: sourceType)
            }
    }
}


