//
//  ImagePicker.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import MobileCoreServices
import AVFoundation

final class ImagePicker: NSObject {
    static let shared = ImagePicker()
    private var isVideo: Bool!
    private var comletion: (( _ image: UIImage?) -> Void)!
    private var dataComletion: (( _ data: Data?, _ image: UIImage?, _ mimeType: String?) -> Void)!

    static func pickImage(sender: UIView, completion: @escaping (_ image: UIImage?) -> Void) {
        ImagePicker.shared.comletion = completion
        ActionSheet.show(title: "Pick Your Picture", cancelTitle: "Cancel",
                         otherTitles: ["Choose from Library", "Take a Picture from Camera"],
                         sender: sender) { index in
            if index == 0 { return }
            ImagePicker.shared.isVideo = false
            self.pickImage(sourceType: index == 1 ? .photoLibrary : .camera)
        }
   }
    
    static func pickVideo(sender: UIView, completion: @escaping (_ data: Data?, _ image: UIImage?, _ mimeType: String?) -> Void) {
        ImagePicker.shared.dataComletion = completion
        ImagePicker.shared.isVideo = true
        self.pickVideo()
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if ImagePicker.shared.isVideo {
            guard let videoUrl = info[.mediaURL] as? URL else {
                ImagePicker.shared.dataComletion(nil, nil, nil)
                picker.dismiss(animated: true, completion: nil)
                return
            }
            do {
                let data = try Data(contentsOf: videoUrl)
                AVAsset(url: videoUrl).generateThumbnail { image in
                    DispatchQueue.main.async {
                        ImagePicker.shared.dataComletion(data, image, videoUrl.pathExtension)
                        picker.dismiss(animated: true, completion: nil)
                    }
                }
            } catch {
                ImagePicker.shared.dataComletion(nil, nil, nil)
                picker.dismiss(animated: true, completion: nil)
            }
        } else {
            let image = info[.editedImage]
            ImagePicker.shared.comletion(image as? UIImage)
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if ImagePicker.shared.isVideo {
            ImagePicker.shared.dataComletion(nil, nil, nil)
        } else {
            ImagePicker.shared.comletion(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    static private func pickImage(sourceType : UIImagePickerController.SourceType)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = ImagePicker.shared
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        UIApplication.topViewController()?.present(imagePicker, animated: true, completion: nil)
    }
    
    static private func pickVideo()  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = ImagePicker.shared
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.movie", "public.video"]
        imagePicker.allowsEditing = true
        UIApplication.topViewController()?.present(imagePicker, animated: true, completion: nil)
    }
}
