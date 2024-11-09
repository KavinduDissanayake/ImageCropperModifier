//
//  ImageCropperModifier.swift
//  ImageCropperModifierExample
//
//  Created by KavinduDissanayake on 2024-11-10.
//
import SwiftUI
import Mantis

// MARK: - Image Cropper Modifier
struct ImageCropperModifier: ViewModifier {
    @Binding var croppedImage: UIImage?
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showImageCropper = false

    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $showImageCropper) {
                ImageCropper(
                    image: $selectedImage,
                    cropShapeType: .constant(.square),
                    presetFixedRatioType: .constant(.canUseMultiplePresetFixedRatio())
                ) { croppedImage in
                    self.croppedImage = croppedImage
                }
            }
            .modifier(ImagePickerButtonModifier(image: $selectedImage, showImagePicker: $showImagePicker))
            .onChange(of: showImagePicker) { newValue in
                if selectedImage != nil && !newValue {
                    showImageCropper = true
                }
            }
    }
}

extension View {
    func imageCropperModifier(croppedImage: Binding<UIImage?>) -> some View {
        self.modifier(ImageCropperModifier(croppedImage: croppedImage))
    }
}
