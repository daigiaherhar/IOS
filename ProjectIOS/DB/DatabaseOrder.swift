////
////  DatabaseOrder.swift
////  ProjectIOS
////
////  Created by Van Tan Vu on 8/8/20.
////  Copyright © 2020 OfTung. All rights reserved.
////
//
//import Foundation
//import UIKit
//import os.log
//
//class MyDatabaseOrder {
//    //MARK: Properties
//    let dPath: String
//    let DB_NAME: String = "ShoesStore.sqlite"
//    let db: FMDatabase?
//
//    //MARK: table's properties
//    let TABLE_SHOE : String = "shoe"
//    let SHOE_ID = "_id"
//    let SHOE_NAME = "name"
//    let SHOE_AMOUNT = "amount"
//    let PRICE_ENTERED = "priceEntered"
//    let SHOE_PRICE = "price"
//    let SHOE_IMAGE = "image"
//
//
//    init() {
//        let derectories: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
//        dPath = derectories[0] + "/" + DB_NAME
//        db = FMDatabase(path: dPath)
//        if db == nil {
//            os_log("Can not create the database. Please review the dPath! ")
//        }
//        else{
//            os_log("database is create successful")
//        }
//    }
//
//    //MARK:
//      func createShoe() -> Bool {
//          var ok: Bool = false
//          if db != nil {
//              let sql = "CREATE TABLE " + TABLE_SHOE + "(" + SHOE_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + SHOE_NAME + " TEXT, " + SHOE_AMOUNT + " TEXT," + PRICE_ENTERED + " TEXT," + SHOE_PRICE + " TEXT," + SHOE_IMAGE + " TEXT)"
//              if db!.executeStatements(sql){
//                  ok = true
//                  os_log("Table created!")
//              }
//              else {
//                  os_log("Can not create the table!")
//              }
//          }
//          else {
//              os_log("Database is nil!")
//          }
//          return ok;
//      }
//
//    func open () -> Bool {
//          var ok: Bool = false
//          if db != nil {
//              guard db!.open() else {
//                  fatalError("Can not open the database: \(db!.lastErrorMessage())")
//              }
//              ok = true
//              os_log("Database is opened!", log: .default, type: .debug)
//          }
//          else {
//              os_log("Datsbase is nil!", log: .default, type: .debug)
//          }
//          return ok
//      }
//
//    func close() {
//          if db != nil{
//              db?.close()
//          }
//      }
//
//    //MARK: Database APIs
//       func insertShoe(shoe: Shoe){
//           if db != nil{
//               //Transform the meal image
//            let imageData: NSData = shoe.image!.pngData()! as NSData
//               let genderImagesString = imageData.base64EncodedData(options: .lineLength64Characters);
//               let sql = "INSERT INTO " + TABLE_SHOE + "(" + SHOE_NAME + ", " + SHOE_AMOUNT + ", " + PRICE_ENTERED + ", " + SHOE_PRICE + ", " + SHOE_IMAGE + ")" + "VALUES (?, ?, ?, ?, ?)"
//
//            if db!.executeUpdate(sql, withArgumentsIn: [shoe.name, shoe.amount, shoe.priceEntered, shoe.price, genderImagesString]){
//                   os_log("the customer is insert to the database")
//               }
//               else{
//                   os_log("fail to insert the customer")
//               }
//           }
//           else{
//               os_log("database is nil")
//           }
//       }
//
//    func deleteShoe(shoe: Shoe) {
//        if db != nil{
//            //Transform the meal image
//            let sql = "DELETE FROM \(TABLE_SHOE) WHERE \(SHOE_NAME) = ?"
//            do{
//                try db!.executeUpdate(sql, values: [shoe.name])
//                os_log("the meal is deleted")
//            }
//            catch{
//                os_log("fail to delete the meal!")
//            }
//        }
//        else{
//            os_log("database is nil")
//        }
//    }
//
//    func readShoe(shoe:inout [Shoe]) {
//        if db != nil{
//            //Transform the meal image
//            var results: FMResultSet?
//            let sql = "SELECT * FROM \(TABLE_SHOE)"
//            do{
//                results = try db!.executeQuery(sql, values: nil)
//            }
//            catch{
//                print("Fail to read data: \(error.localizedDescription)")
//            }
//            if results != nil {
//                while (results?.next())! {
//                    let shoeName = results!.string(forColumn: SHOE_NAME) ?? ""
//                    let shoeAmount = results!.string(forColumn: SHOE_AMOUNT) ?? ""
//                    let priceEnterd = results!.string(forColumn: PRICE_ENTERED) ?? ""
//                    let shoePrice = results!.string(forColumn: SHOE_PRICE) ?? ""
//                    let stringImage = results!.string(forColumn: SHOE_IMAGE)
//
//
//                    let dataImage: Data = Data(base64Encoded: stringImage!, options: .ignoreUnknownCharacters)!
//                    let shoeImage = UIImage(data: dataImage)
//
//                    let shoe1 = Shoe(name: shoeName, amount: shoeAmount, priceEntered: priceEnterd, price: shoePrice, image: shoeImage)
//                    shoe.append(shoe1!)
//                }
//            }
//        }
//        else{
//            os_log("database is nil!")
//        }
//    }
//
//    func updateShoe(oldShoe: Shoe, newShoe: Shoe) {
//        if db != nil{
//            //            let sql = "UPDATE \(TABLE_CUS) SET \(CUS_NAME) = ?, \(CUS_PHONE) = ? \(CUS_ADDRESS) = ? \(CUS_EMAIL) = ? \(CUS_GENDER) = ? WHERE \(CUS_NAME) = ? AND \(CUS_PHONE) = ?"
//            let sql = "UPDATE \(TABLE_SHOE) SET \(SHOE_NAME) = ?, \(SHOE_AMOUNT) = ?, \(PRICE_ENTERED) = ?, \(SHOE_PRICE) = ?, \(SHOE_IMAGE) = ? WHERE \(SHOE_NAME) = ? AND \(SHOE_PRICE) = ?"
//            let newImageData: NSData = newShoe.image!.pngData()! as NSData
//            let newStringImage = newImageData.base64EncodedData(options: .lineLength64Characters)
//
//            do{
//                try db!.executeUpdate(sql, values: [newShoe.name, newShoe.amount, newShoe.priceEntered, newShoe.price, newStringImage, oldShoe.name, oldShoe.price])
//                os_log("Successful to update the cus!")
//            }
//            catch{
//                print("fail to update the cus: \(error.localizedDescription)")
//            }
//        }
//        else{
//            os_log("Data is nil!")
//        }
//    }
//
//}
