//
//  CustomerTableViewController.swift
//  ProjectIOS
//
//  Created by Tran Thang on 7/25/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class CustomerTableViewController: UITableViewController {
    enum NavigationDerection {
              case addCus
              case updateCus
          }
          var navigationDirection: NavigationDerection = .addCus
    private var customerList=[Customer]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCustomer()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func loadCustomer(){
        if let customer = Customer(name: "Ai vay", phone: "123456AA", address: "23 ba trung", email: "hatxi@gmail.com",gender: UIImage(named: "Male")){
           customerList += [customer]
           }
          if let customer = Customer(name: "Ai bit", phone: "123456AA", address: "23 ba trung", email: "hatxi@gmail.com",gender: UIImage(named: "Female")){
           customerList += [customer]
           }
       }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customerList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CustommerTableViewCell"
               guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustommerTableViewCell else {
                   fatalError("Can not read the cell")
               }
               
               let customer = customerList[indexPath.row]
               cell.txtName.text = customer.name
        cell.txtPhone.text = customer.phone
               cell.txtAddress.text = customer.address
        cell.txtEmail.text = customer.email
        cell.imgGender.image = customer.gender
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        guard let destinationController = segue.destination as? CustomerViewController else {
            print("can not get the destination controller")
            return
        }
        switch identifier {
        case "addCus":
            print("add a new meal")
            navigationDirection = .addCus
            destinationController.navigationDirection = .addCus
       
        default:
            print("You are not name the segue!")
        }
    }
    @IBAction func unWindFromCusTomerViewController(sender:UIStoryboardSegue){
           switch navigationDirection {
           case .addCus:
               if let sourceController = sender.source as? CustomerViewController, let newCus = sourceController.customer{
                   //Calculate new possition in the table
                   let newIndexPath = IndexPath(row: customerList.count, section: 0)
                   //add the new meal into the mealList
                   customerList.append(newCus)
                   //Insert the newmeal into the tableview
                   tableView.insertRows(at: [newIndexPath], with: .automatic)
               }
    
           default:
               print("unknown the direction!")
               break
           }
           
           
       }
}
