//
//  ViewController.swift
//  UIImagePickerController
//
//  Created by Engy on 11/3/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var personalImage: UIImageView!
    @IBOutlet var photoLibraryImage: UIImageView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure images and gestures
        configurePersonalImage()
        configurePhotoLibraryImage()
    }

    // MARK: - Setup Methods
    private func configurePersonalImage() {
        // Style personal image as circular with border
        personalImage.layer.borderWidth = 2
        personalImage.layer.cornerRadius = personalImage.frame.height / 2
        personalImage.clipsToBounds = true

        // Add tap gesture for camera selection
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCamera))
        personalImage.isUserInteractionEnabled = true
        personalImage.addGestureRecognizer(tapGesture)
    }

    private func configurePhotoLibraryImage() {
        // Add tap gesture for photo library selection
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        photoLibraryImage.isUserInteractionEnabled = true
        photoLibraryImage.addGestureRecognizer(tapGesture)
    }

    // MARK: - Actions
    @objc private func openCamera() {
        openImagePicker(sourceType: .camera)
    }

    @objc private func openPhotoLibrary() {
        openImagePicker(sourceType: .photoLibrary)
    }

    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Retrieve and set the selected image based on the source type
        if let selectedImage = info[.originalImage] as? UIImage {
            if picker.sourceType == .camera {
                personalImage.image = selectedImage
            } else if picker.sourceType == .photoLibrary {
                photoLibraryImage.image = selectedImage
            }
        }
        dismiss(animated: true)
    }
}
