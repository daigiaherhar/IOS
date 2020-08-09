//
//  DatabaseOrder.swift
//  ProjectIOS
//
//  Created by Van Tan Vu on 8/8/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import Foundation
import UIKit
import os.log

class MyDatabaseOrder {
    //MARK: Properties
    let dPath: String
    let DB_NAME: String = "ShoesStore.sqlite"
    let db: FMDatabase?
    
    //MARK: table's properties
    let TABLE_ORDER : String = "orderShoe"
    let ORDER_ID: String = "_id"
    let ORDER_CUS_NAME = "customerName"
    let ORDER_PHONE = "phone"
    let ORDER_ADDRESS = "address"
    let ORDER_SHOE_NAME = "shoeName"
    let ORDER_PRICE = "price"
    let ORDER_AMOUNT = "amount"
    let ORDER_TOTAL = "toatalMoney"
    let ORDER_STATUS = "status"
    
    init() {
        let derectories: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        dPath = derectories[0] + "/" + DB_NAME
        db = FMDatabase(path: dPath)
        if db == nil {
            os_log("Can not create the database. Please review the dPath! ")
        }
        else{
            os_log("database is create successful")
        }
    }
    
    //MARK:
      func createOrder() -> Bool {
          var ok: Bool = false
          if db != nil {
              let sql = "CREATE TABLE " + TABLE_ORDER + "(" + ORDER_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + ORDER_CUS_NAME + " TEXT, " + ORDER_PHONE + " TEXT, " + ORDER_ADDRESS + " TEXT, " + ORDER_SHOE_NAME + " TEXT, " + ORDER_PRICE + " TEXT, "  + ORDER_AMOUNT + " TEXT, "  + ORDER_TOTAL + " TEXT, "  + ORDER_STATUS + " TEXT)"
              if db!.executeStatements(sql){
                  ok = true
                  os_log("Table created!")
              }
              else {
                  os_log("Can not create the table!")
              }
          }
          else {
              os_log("Database is nil!")
          }
          return ok;
      }
    
    func open () -> Bool {
          var ok: Bool = false
          if db != nil {
              guard db!.open() else {
                  fatalError("Can not open the database: \(db!.lastErrorMessage())")
              }
              ok = true
              os_log("Database is opened!", log: .default, type: .debug)
          }
          else {
              os_log("Datsbase is nil!", log: .default, type: .debug)
          }
          return ok
      }
    
    func close() {
          if db != nil{
              db?.close()
          }
      }
    
    //MARK: Database APIs
    func insertOrder(order: Order){
        if db != nil{
            //Transform the meal image
            let sql = "INSERT INTO " + TABLE_ORDER + "(" + ORDER_CUS_NAME + ", " + ORDER_PHONE + ", " + ORDER_ADDRESS + ", " + ORDER_SHOE_NAME + ", " + ORDER_PRICE + ", " + ORDER_AMOUNT + ", " + ORDER_TOTAL + ", " + ORDER_STATUS + ")" + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            
            if db!.executeUpdate(sql, withArgumentsIn: [order.customerName, order.phone, order.address, order.shoeName, order.price, order.amount, order.totalMoney, order.status]){
                os_log("the customer is insert to the database")
            }
            else{
                os_log("fail to insert the customer")
            }
        }
        else{
            os_log("database is nil")
        }
    }
    
    func deleteOrder(order: Order) {
        if db != nil{
            //Transform the meal image
            let sql = "DELETE FROM \(TABLE_ORDER) WHERE \(ORDER_CUS_NAME) = ? AND \(ORDER_SHOE_NAME) = ?"
            do{
                try db!.executeUpdate(sql, values: [order.customerName, order.shoeName])
                os_log("the meal is deleted")
            }
            catch{
                os_log("fail to delete the meal!")
            }
        }
        else{
            os_log("database is nil")
        }
    }
    
    func readOrder(order:inout [Order]) {
        if db != nil{
            //Transform the meal image
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_ORDER)"
            do{
                results = try db!.executeQuery(sql, values: nil)
            }
            catch{
                print("Fail to read data: \(error.localizedDescription)")
            }
            if results != nil {
                while (results?.next())! {
                    let cusName = results!.string(forColumn: ORDER_CUS_NAME) ?? ""
                    let phone = results!.string(forColumn: ORDER_PHONE) ?? ""
                    let address = results!.string(forColumn: ORDER_ADDRESS) ?? ""
                    let shoeName = results!.string(forColumn: ORDER_SHOE_NAME) ?? ""
                    let price = results!.string(forColumn: ORDER_PRICE) ?? ""
                    let orderAmount = results!.string(forColumn: ORDER_AMOUNT) ?? ""
                    let totalMoney = results!.string(forColumn: ORDER_TOTAL) ?? ""
                    let status = results!.string(forColumn: ORDER_STATUS) ?? ""
                    
                    let order1 = Order(customerName: cusName, phone: phone, address: address, shoeName: shoeName, price: price, amount: orderAmount, totalMoney: totalMoney, status: status)
                    order.append(order1!)
                }
            }
        }
        else{
            os_log("database is nil!")
        }
    }
    
    func updateOrder(oldOrder: Order, newOrder: Order) {
        if db != nil{
            //            let sql = "UPDATE \(TABLE_CUS) SET \(CUS_NAME) = ?, \(CUS_PHONE) = ? \(CUS_ADDRESS) = ? \(CUS_EMAIL) = ? \(CUS_GENDER) = ? WHERE \(CUS_NAME) = ? AND \(CUS_PHONE) = ?"
            let sql = "UPDATE \(TABLE_ORDER) SET \(ORDER_CUS_NAME) = ?, \(ORDER_PHONE) = ?, \(ORDER_ADDRESS) = ?, \(ORDER_SHOE_NAME) = ?, \(ORDER_PRICE) = ? , \(ORDER_AMOUNT) = ? , \(ORDER_TOTAL) = ? , \(ORDER_STATUS) = ? WHERE \(ORDER_CUS_NAME) = ? AND \(ORDER_SHOE_NAME) = ?"
            do{
                try db!.executeUpdate(sql, values: [newOrder.customerName, newOrder.phone, newOrder.address, newOrder.shoeName, newOrder.price, newOrder.amount, newOrder.totalMoney, newOrder.status, oldOrder.customerName, oldOrder.shoeName])
                os_log("Successful to update the cus!")
            }
            catch{
                print("fail to update the cus: \(error.localizedDescription)")
            }
        }
        else{
            os_log("Data is nil!")
        }
    }
    
}
