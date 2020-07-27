//
//  OrderViewController.swift
//  ProjectIOS
//
//  Created by Van Tan Vu on 7/26/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    enum NavigationDerection {
        case addNewOrder
        case updateOrder
    }
    var navigationDerection: NavigationDerection = .addNewOrder
    var order:Order?
    @IBOutlet weak var edtCustomerName: UITextField!
    @IBOutlet weak var edtPhone: UITextField!
    @IBOutlet weak var edtAddress: UITextField!
    @IBOutlet weak var edtShoeName: UITextField!
    @IBOutlet weak var edtPrice: UITextField!
    @IBOutlet weak var edtAmount: UITextField!
    @IBOutlet weak var edtToltalMoney: UITextField!
    @IBOutlet weak var edtStatus: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Uy quyen
        edtCustomerName.delegate = self
        edtPhone.delegate = self
        edtAddress.delegate = self
        edtShoeName.delegate = self
        edtPrice.delegate = self
        edtAmount.delegate = self
        edtToltalMoney.delegate = self
        edtStatus.delegate = self
            //Get the meal from Table view controller
            if let theOrder = order{
                navigationItem.title = theOrder.customerName
                edtCustomerName.text = theOrder.customerName
                edtPhone.text = theOrder.phone
                edtAddress.text = theOrder.address
                edtShoeName.text = theOrder.shoeName
                edtPrice.text = String(theOrder.price)
                edtAmount.text = String(theOrder.amount)
                edtToltalMoney.text = String(theOrder.totalMoney)
                edtStatus.text = String(theOrder.status)
            }
            updateSaveButton()
        
    }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            edtCustomerName.resignFirstResponder()
            edtPhone.resignFirstResponder()
            edtAddress.resignFirstResponder()
            edtShoeName.resignFirstResponder()
            edtPrice.resignFirstResponder()
            edtAmount.resignFirstResponder()
            edtToltalMoney.resignFirstResponder()
            edtStatus.resignFirstResponder()
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            navigationItem.title = edtShoeName.text
            updateSaveButton()
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            saveButton.isEnabled = false
        }
        
        //MARK: For navigtion controller
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let pressedButton = sender as? UIBarButtonItem, pressedButton === saveButton else{
                print("///")
                return
            }
            //Proparing for the save button pressed
            let cusstomerName = edtCustomerName.text ?? ""
            let phone = edtPhone.text ?? ""
            let address = edtAddress.text ?? ""
            let shoeName = edtShoeName.text ?? ""
            let price = edtPrice.text ?? ""
            let amount = edtAmount.text ?? ""
            let totalMoney = edtToltalMoney.text ?? ""
            let status = edtStatus.text ?? ""
            order = Order(customerName: cusstomerName, phone: phone, address: address, shoeName: shoeName, price: price, amount: amount, totalMoney: totalMoney, status: status)
        }
        //MARK: Update save button
        func updateSaveButton() {
            let customerName = edtCustomerName.text ?? ""
            saveButton.isEnabled = !customerName.isEmpty
        }
        
        @IBAction func cancel(_ sender: Any) {
            switch navigationDerection {
            case .addNewOrder:
                dismiss(animated: true, completion: nil)
            case .updateOrder:
                if let theNavigationController = navigationController {
                    theNavigationController.popViewController(animated: true)
                }
            }
            
        }

}
