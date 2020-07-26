//
//  CustomerViewController.swift
//  ProjectIOS
//
//  Created by Tran Thang on 7/25/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgGioiTinh: UIImageView!
    
    var gioiTinh = Bool(true)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SelectGender(_ sender: UITapGestureRecognizer) {
        print("the picture is tapped")
        if gioiTinh == true{
            //imgGioiTinh.image(named)
        }
        
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
