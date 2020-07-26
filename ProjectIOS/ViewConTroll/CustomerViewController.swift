//
//  CustomerViewController.swift
//  ProjectIOS
//
//  Created by Tran Thang on 7/25/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var gender = Bool(true)
    
    enum NavigationDerection {
           case addCus
           case updateCus
       }
       var navigationDirection: NavigationDerection = .addCus
       
       var customer:Customer?
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgGioiTinh: UIImageView!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SelectGender(_ sender: UITapGestureRecognizer) {
        //print("the picture is tapped")
            if gender == true{
                imgGioiTinh.image = UIImage(named: "Female")
                gender = false
            }else{
                imgGioiTinh.image = UIImage(named: "Male")
                               gender = true
        }
        
    }
    
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pressButton = sender as? UIBarButtonItem, pressButton === btnSave else{
            print("xxxxxxx!")
            return
        }
        let name = txtName.text ?? ""
        let phone = txtPhone.text ?? ""
        let address = txtAddress.text ?? ""
        let email = txtEmail.text ?? ""
        //preparing for the save button pressed
        customer = Customer(name: name, phone: phone, address: address, email: email, gender: imgGioiTinh.image)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
