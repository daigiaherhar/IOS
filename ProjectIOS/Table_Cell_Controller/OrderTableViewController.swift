//
//  OrderTableViewController.swift
//  ProjectIOS
//
//  Created by NguyenHuynhHoangSang on 7/26/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    private var orderList = [Order]()
    let dao = MyDatabaseOrder()
    
    static var isCreate: Bool = false
    //Mark the direction of navigation
       enum NavigationDerection {
           case addNewOrder
           case updateOrder
       }
       var navigationDerection: NavigationDerection = .addNewOrder
        override func viewDidLoad() {
        super.viewDidLoad()
        loadOrder()
        navigationItem.leftBarButtonItem = editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "OrderTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OrderTableViewCell else {
                   fatalError("Can not read the cell")
               }
        let order = orderList[indexPath.row]
        cell.customerName.text = order.customerName
        cell.amount.text = String(order.amount)
        cell.status.text = order.status
        cell.totalMoney.text = String(order.totalMoney)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if dao.open(){
                dao.deleteOrder(order: orderList[indexPath.row])
            }
            // Delete the row from the data source
            orderList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier ?? ""
        //Get the destination of segue
        guard let destinationController = segue.destination as? OrderViewController else {
            print("Can not get the destination controller")
            return
        }
        switch identifier {
        case "addOrder":
            print("add new meal")
            navigationDerection = .addNewOrder
        case "updateOrder":
            //Get the selected Cell
            navigationDerection = .updateOrder
            //Mark the destinaton
            destinationController.navigationDerection = .updateOrder
            guard let selectedCell = sender as? OrderTableViewCell else {
                print("Can not get the sellected cell")
                return
            }
            // Get the position of selected cell in the mealList
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                print("Can not the position of the selected Cell!")
                return
            }
            //Get the meal of selected cell to give the destination controller
            destinationController.order = orderList[indexPath.row]
        default:
            print("you are not named the sugue!")
            return
        }
    }
    
    
    func loadOrder(){
        if dao.open(){
            if !OrderTableViewController.isCreate{
                OrderTableViewController.isCreate = dao.createOrder()
            }
            dao.readOrder(order: &orderList)
        }
        if orderList.count == 0{
            if let order = Order(customerName: "nguyen A", phone: "012234", address: "12/2 abc", shoeName: "giay a", price: "1000000", amount: "2", totalMoney: "200000", status: "Dang giao hang"){
                orderList += [order]
                dao.insertOrder(order: order)
            }
        }
    }
    @IBAction func unWindFromDetailOrderContronller(sender:UIStoryboardSegue)
    {
        //Get the new meal from MealDetailController
        switch navigationDerection {
        case .addNewOrder:
            if let sourceController = sender.source as? OrderViewController, let newOrder = sourceController.order {
                //Caculate new position in the table
                let newIndexPath = IndexPath(row: orderList.count, section: 0)
                //Add the new into the mealList
                orderList.append(newOrder)
                //Insert the newmeal into the tableview
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                if dao.open(){
                    dao.insertOrder(order: newOrder)
                }
            }
        case .updateOrder:
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                if let sourceController = sender.source as? OrderViewController, let updateOrder = sourceController.order {
                    if dao.open(){
                        dao.updateOrder(oldOrder: orderList[selectedIndexPath.row], newOrder: updateOrder)
                    }
                    //Update to the Meal list
                    orderList[selectedIndexPath.row] = updateOrder
                    //Update to table view
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            }
        default:
            break
        }
    }

}
