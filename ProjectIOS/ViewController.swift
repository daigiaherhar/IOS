//
//  ViewController.swift
//  ProjectIOS
//
//  Created by Tran Thang on 7/23/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var edtShoeName: UITextField!
    @IBOutlet weak var edtAmout: UITextField!
    @IBOutlet weak var edtPriceEntered: UITextField!
    @IBOutlet weak var edtPrice: UITextField!
    @IBOutlet weak var imageShoe: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            edtShoeName.resignFirstResponder()
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
    //        lblMealName.text = edtMealName.text
        }
    
    @IBAction func tapOnPictureAction(_ sender: UITapGestureRecognizer) {
        edtShoeName.resignFirstResponder()
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: delegate funcion of image picker controller
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            fatalError("can not get the image")
        }
        //load image to the imageview
        imageShoe.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}

