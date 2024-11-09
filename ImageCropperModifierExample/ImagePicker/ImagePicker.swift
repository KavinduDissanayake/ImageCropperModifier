//
//  ImagePicker.swift
//  ImageCropperModifierExample
//
//  Created by KavinduDissanayake on 2024-11-10.
//
import Mantis
import PhotosUI
import SwiftUI
// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.isShown = false
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - Image Cropper
struct ImageCropper: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var cropShapeType: Mantis.CropShapeType
    @Binding var presetFixedRatioType: Mantis.PresetFixedRatioType
    var onImageCropped: ((UIImage) -> Void)?

    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UINavigationController {
           // Configure Mantis with desired settings
           var config = Mantis.Config()
           config.presetFixedRatioType = presetFixedRatioType
           config.cropShapeType = cropShapeType
           config.showRotationDial = true // Keep rotation dial visible if needed

           let cropViewController = Mantis.cropViewController(image: image!, config: config)
           cropViewController.delegate = context.coordinator

           // Set the cropper view background to black
           cropViewController.view.backgroundColor = .black

           // Create a custom close button with a white image
           let closeButton = UIButton(type: .custom)
           closeButton.setImage(UIImage(systemName: "xmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
           closeButton.addTarget(context.coordinator, action: #selector(Coordinator.dismissCropper), for: .touchUpInside)
           
           // Set the custom close button as the right bar button item
           cropViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
           cropViewController.title = "Crop Image"

           // Set up a navigation controller with fixed white title and button colors
           let navigationController = UINavigationController(rootViewController: cropViewController)

           // Apply fixed appearance styles for title and button colors
           let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = .black // Background color of the navigation bar
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // White title color
           appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // White large title color

           // Assign the appearance to different states of the navigation bar
           navigationController.navigationBar.standardAppearance = appearance
           navigationController.navigationBar.scrollEdgeAppearance = appearance
           navigationController.navigationBar.compactAppearance = appearance
           navigationController.navigationBar.tintColor = .white // Ensure all navigation bar icons stay white
           navigationController.navigationBar.isTranslucent = false

           return navigationController
       }
    
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}

    class Coordinator: NSObject, CropViewControllerDelegate {
        func cropViewControllerDidFailToCrop(_ cropViewController: Mantis.CropViewController, original: UIImage) {
            
        }
        
        func cropViewControllerDidBeginResize(_ cropViewController: Mantis.CropViewController) {
            
        }
        
        func cropViewControllerDidEndResize(_ cropViewController: Mantis.CropViewController, original: UIImage, cropInfo: Mantis.CropInfo) {
            
        }
        
        var parent: ImageCropper

        init(_ parent: ImageCropper) {
            self.parent = parent
        }

        func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
            parent.onImageCropped?(cropped)
            parent.presentationMode.wrappedValue.dismiss()
        }

        func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
            parent.presentationMode.wrappedValue.dismiss()
        }

        @objc func dismissCropper() {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
