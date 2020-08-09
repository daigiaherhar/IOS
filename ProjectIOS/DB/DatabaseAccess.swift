//
//  MyDatabaseAccess.swift
//  ProjectIOS
//
//  Created by Tran Thang on 8/7/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import Foundation
import UIKit
import os.log

class MyDatabaseAccess {
    //MARK: Properties
    let dPath: String
    let DB_NAME: String = "ShoesStore.sqlite"
    let db: FMDatabase?
    
    //MARK: table's properties
    let TABLE_CUS : String = "customer"
    let CUS_ID = "_id"
    let CUS_NAME = "name"
    let CUS_PHONE = "phone"
    let CUS_EMAIL = "email"
    let CUS_ADDRESS = "address"
    let CUS_GENDER = "gender"
    
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
      func createCustomer() -> Bool {
          var ok: Bool = false
          if db != nil {
              let sql = "CREATE TABLE " + TABLE_CUS + "(" + CUS_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + CUS_NAME + " TEXT, " + CUS_PHONE + " TEXT," + CUS_EMAIL + " TEXT," + CUS_ADDRESS + " TEXT," + CUS_GENDER + " TEXT)"
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
       func insertCustomer(cus: Customer){
           if db != nil{
               //Transform the meal image
               let imageData: NSData = cus.gender!.pngData()! as NSData
               let genderImagesString = imageData.base64EncodedData(options: .lineLength64Characters);
               let sql = "INSERT INTO " + TABLE_CUS + "(" + CUS_NAME + ", " + CUS_PHONE + ", " + CUS_EMAIL + ", " + CUS_ADDRESS + ", " + CUS_GENDER + ")" + "VALUES (?, ?, ?, ?, ?)"
    
               if db!.executeUpdate(sql, withArgumentsIn: [cus.name, cus.phone, cus.email, cus.address, genderImagesString]){
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
    
    func deleteCustomer(cus: Customer) {
        if db != nil{
            //Transform the meal image
            let sql = "DELETE FROM \(TABLE_CUS) WHERE \(CUS_NAME) = ?"
            do{
                try db!.executeUpdate(sql, values: [cus.name])
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
    
    func readCustomer(cus:inout [Customer]) {
        if db != nil{
            //Transform the meal image
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_CUS)"
            do{
                results = try db!.executeQuery(sql, values: nil)
            }
            catch{
                print("Fail to read data: \(error.localizedDescription)")
            }
            if results != nil {
                while (results?.next())! {
                    let cusName = results!.string(forColumn: CUS_NAME) ?? ""
                    let cusPhone = results!.string(forColumn: CUS_PHONE) ?? ""
                    let cusEmail = results!.string(forColumn: CUS_EMAIL) ?? ""
                    let cusAddress = results!.string(forColumn: CUS_ADDRESS) ?? ""
                    let stringImage = results!.string(forColumn: CUS_GENDER)
                
                    
                    let dataImage: Data = Data(base64Encoded: stringImage!, options: .ignoreUnknownCharacters)!
                    let cusImage = UIImage(data: dataImage)
                    
                    let cus1 = Customer(name:cusName, phone:cusPhone, address:cusAddress, email:cusEmail, gender:cusImage)
                    cus.append(cus1!)
                }
            }
        }
        else{
            os_log("database is nil!")
        }
    }
    
    func updateCustomer(oldCus: Customer, newCus: Customer) {
        if db != nil{
            //            let sql = "UPDATE \(TABLE_CUS) SET \(CUS_NAME) = ?, \(CUS_PHONE) = ? \(CUS_ADDRESS) = ? \(CUS_EMAIL) = ? \(CUS_GENDER) = ? WHERE \(CUS_NAME) = ? AND \(CUS_PHONE) = ?"
            let sql = "UPDATE " + (TABLE_CUS)
                + " SET "
                + CUS_NAME + " = ? " + ", " + CUS_PHONE + " = ? " + ", " + CUS_ADDRESS + " = ? " + ", " + CUS_EMAIL + " = ? " + ", " + CUS_GENDER + " = ? "
                + "WHERE \(CUS_NAME) = ? AND \(CUS_PHONE) = ?"
            let newImageData: NSData = newCus.gender!.pngData()! as NSData
            let newStringImage = newImageData.base64EncodedData(options: .lineLength64Characters)
            
            do{
                try db!.executeUpdate(sql, values: [newCus.name, newCus.phone, newCus.address, newCus.email, newStringImage, oldCus.name,oldCus.phone])
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
