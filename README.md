# Image Cropper Modifier for SwiftUI

A custom SwiftUI modifier, `imageCropperModifier`, that integrates the [Mantis](https://github.com/guoyingtao/Mantis) library to provide image cropping functionality directly within SwiftUI views. This modifier simplifies adding cropping features to any view, making it easy to select, crop, and retrieve an image in SwiftUI.

## Features

- **SwiftUI-Compatible Image Cropping**: Use the `imageCropperModifier` to add image cropping capabilities to any SwiftUI view.
- **Mantis Library Integration**: Leverages the Mantis library for advanced cropping, including aspect ratio selection and free-form cropping.
- **Customizable**: Adjust settings like crop shape, aspect ratio, and preset configurations directly through the modifier.

## Requirements

- iOS 15.0+
- Xcode 15.0+
- Swift 5.3+
- Mantis (installed via Swift Package Manager)

## Installation

1. **Add Mantis**: Install [Mantis](https://github.com/guoyingtao/Mantis) via Swift Package Manager.
2. **Add `imageCropperModifier`**: Include `imageCropperModifier` in your project files.

## Usage

### Basic Usage
The `imageCropperModifier` is a SwiftUI modifier that allows any view to open the image cropping interface. It binds a `UIImage` to store the cropped result.

Example:
```swift
import SwiftUI

struct ContentView: View {
    @State private var croppedImage: UIImage?

    var body: some View {
        VStack {
            Text("Select Profile Picture")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .imageCropperModifier(croppedImage: $croppedImage) // Apply the modifier here

            if let croppedImage = croppedImage {
                Image(uiImage: croppedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
    }
}
```


 
