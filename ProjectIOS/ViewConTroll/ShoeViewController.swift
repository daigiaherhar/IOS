//
//  ViewController.swift
//  ProjectIOS
//
//  Created by Tran Thang on 7/23/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class ShoeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: properties
    enum NavigationDerection {
        case addNewShoe
        case updateShoe
    }
    var navigationDerection: NavigationDerection = .addNewShoe
    var shoe:Shoe?
    @IBOutlet weak var edtShoeName: UITextField!
    @IBOutlet weak var edtAmout: UITextField!
    @IBOutlet weak var edtPriceEntered: UITextField!
    @IBOutlet weak var edtPrice: UITextField!
    @IBOutlet weak var imageShoe: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Uy quyen
        edtShoeName.delegate = self
        edtAmout.delegate = self
        edtPriceEntered.delegate = self
        edtPrice.delegate = self
        //Get the meal from Table view controller
        if let theShoe = shoe{
            navigationItem.title = theShoe.name
            edtShoeName.text = theShoe.name
            edtAmout.text = theShoe.amount
            edtPriceEntered.text = theShoe.priceEntered
            edtPrice.text = theShoe.price
            imageShoe.image = theShoe.image
        }
        updateSaveButton()    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            edtShoeName.resignFirstResponder()
        edtPriceEntered.resignFirstResponder()
        edtAmout.resignFirstResponder()
        edtPrice.resignFirstResponder()
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            navigationItem.title = edtShoeName.text
            updateSaveButton()
        }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
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
    //MARK: For navigtion controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pressedButton = sender as? UIBarButtonItem, pressedButton === saveButton else{
            print("///")
            return
        }
        //Proparing for the save button pressed
        let shoeName = edtShoeName.text ?? ""
        let amount = edtAmout.text ?? ""
        let priceEntered = edtPriceEntered.text ?? ""
        let price = edtPrice.text ?? ""
        shoe = Shoe(name: shoeName, amount: amount, priceEntered: priceEntered, price: price, image: imageShoe.image)
    }
    //MARK: Update save button
    func updateSaveButton() {
        let mealName = edtShoeName.text ?? ""
        saveButton.isEnabled = !mealName.isEmpty
    }
    
    @IBAction func cancel(_ sender: Any) {
        switch navigationDerection {
        case .addNewShoe:
            dismiss(animated: true, completion: nil)
        case .updateShoe:
            if let theNavigationController = navigationController {
                theNavigationController.popViewController(animated: true)
            }
        }
        
    }
    
}

