//
//  ReconocimientoViewController.swift
//  [NAH]
//
//  Created by Jose Tlacuilo on 17/04/21.
//

import UIKit

class ReconocimientoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            self.cameraButton.isHidden = true
        }
        self.imagePicker.delegate = self
    }
    
    @IBAction func openCamera(_ sender: Any) {
        self.imagePicker.sourceType = .camera
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openAlbum(_ sender: Any) {
        self.imagePicker.sourceType = .photoLibrary
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    // MARK: ImagePicker Delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
}
