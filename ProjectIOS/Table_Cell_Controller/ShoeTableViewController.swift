//
//  ShoeTableViewController.swift
//  ProjectIOS
//
//  Created by Van Tan Vu on 7/25/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class ShoeTableViewController: UITableViewController {
    private var shoeList = [Shoe]()
    //Mark the direction of navigation
    enum NavigationDerection {
        case addNewShoe
        case updateShoe
    }
    var navigationDerection: NavigationDerection = .addNewShoe
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadShoe()
        //add the edit button
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
        return shoeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ShoeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ShoeTableViewCell else {
            fatalError("Can not read the cell")
        }
        
        let shoe = shoeList[indexPath.row]
        cell.shoeName.text = shoe.name
        cell.shoePrice.text = shoe.price
        cell.shoeImage.image = shoe.image
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
            // Delete the row from the data source
            shoeList.remove(at: indexPath.row)
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
        guard let destinationController = segue.destination as? ShoeViewController else {
            print("Can not get the destination controller")
            return
        }
        switch identifier {
        case "addShoe":
            print("add new meal")
            navigationDerection = .addNewShoe
        case "updateShoe":
            //Get the selected Cell
            navigationDerection = .updateShoe
            //Mark the destinaton
            destinationController.navigationDerection = .updateShoe
            guard let selectedCell = sender as? ShoeTableViewCell else {
                print("Can not get the sellected cell")
                return
            }
            // Get the position of selected cell in the mealList
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                print("Can not the position of the selected Cell!")
                return
            }
            //Get the meal of selected cell to give the destination controller
            destinationController.shoe = shoeList[indexPath.row]
        default:
            print("you are not named the sugue!")
            return
        }
    }
    
    
    func loadShoe(){
    if let shoe = Shoe(name: "Bitis hunter X", amount: "20", priceEntered: "200000", price: "500000", image: UIImage(named: "DefaultImage")){
        shoeList += [shoe]
        }
        if let shoe1 = Shoe(name: "Bitis hunter X", amount: "20", priceEntered: "200000", price: "500000", image: UIImage(named: "DefaultImage")){
               shoeList += [shoe1]
               }
    }
    @IBAction func unWindFromDetailShoeContronller(sender:UIStoryboardSegue)
    {
        //Get the new meal from MealDetailController
        switch navigationDerection {
        case .addNewShoe:
            if let sourceController = sender.source as? ShoeViewController, let newShoe = sourceController.shoe {
                //Caculate new position in the table
                let newIndexPath = IndexPath(row: shoeList.count, section: 0)
                //Add the new into the mealList
                shoeList.append(newShoe)
                //Insert the newmeal into the tableview
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .updateShoe:
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                if let sourceController = sender.source as? ShoeViewController, let updateShoe = sourceController.shoe {
                    //Update to the Meal list
                    shoeList[selectedIndexPath.row] = updateShoe
                    //Update to table view
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            }
        default:
            break
        }
    }
}
