//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Trista on 2021/2/16.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    //宣告用來操作 Core Data 的常數
    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //宣告一個 Entity 的名稱,要與xcdatamodeld檔案新增的Entity名稱一樣，以供後續使用
    let myEntityName = "Student"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //使用NSEntityDescription類別的insertNewObject()方法新增資料
        //傳入兩個參數分別為一開始宣告的 Entity 名稱及用來操作 Core Data 的常數
        //回傳一個 Student 的實體並指派給常數student
        let student = NSEntityDescription.insertNewObject(forEntityName: myEntityName, into: myContext) as! Student

        student.id = 1
        student.name = "Linda"
        student.height = 167.3

        /*使用do-catch語句來定義錯誤的捕獲(catch)及處理，每一個catch表示可以捕獲到一個錯誤拋出的處理方式
         do {
             try 拋出函式
             其他執行的程式
         } catch 錯誤1 {
             處理錯誤1
         } catch 錯誤2 {
             處理錯誤2
         }
        */
        do{
            //使用操作 Core Data 的常數的save()方法來儲存資料
            try myContext.save()
        }
        catch{
            fatalError("\(error)")
        }
        
        
        //讀取資料
        //使用類別NSFetchRequest設置要取得的 Entity，建立一個取得資料的請求(request)
        var request = NSFetchRequest<NSFetchRequestResult>(entityName: myEntityName)
        
        //依 id 由小到大排序
        //使用屬性sortDescriptors額外設定取得資料排序的方式，是一個型別為[NSSortDescriptor]的陣列，可以填入多個排序方式
        //兩個參數依序為要依照哪一個 attribute 排序以及是否由小排到大
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

        /*使用do-catch語句來定義錯誤的捕獲(catch)及處理，每一個catch表示可以捕獲到一個錯誤拋出的處理方式
         do {
             try 拋出函式
             其他執行的程式
         } catch 錯誤1 {
             處理錯誤1
         } catch 錯誤2 {
             處理錯誤2
         }
        */
        do {
            //使用操作 Core Data 的常數的fetch()方法來取得資料
            //傳入參數是使用類別NSFetchRequest設置要取得的 Entity，建立一個取得資料的請求(request)
            //順利取回的資料是一個型別為[Student]的陣列
            let results =
                try myContext.fetch(request) as! [Student]

            //使用for-in迴圈從型別為[Student]的陣列來依序取得每筆資料
            for result in results {
                print("\(result.id). \(result.name!)")
                print("身高： \(result.height)")
            }
        } catch {
            fatalError("\(error)")
        }
        
        
        //更新資料
        //更新資料前需要先讀取資料
        //使用類別NSFetchRequest設置要取得的 Entity，建立一個取得資料的請求(request)
        request = NSFetchRequest<NSFetchRequestResult>(entityName: myEntityName)
        
        //使用屬性predicate，設定取得資料的條件
        //每次新的查詢要設定屬性predicate前，要先將其設置為nil以清空查詢條件
        request.predicate = nil
        let updateID = 1
        
        //查詢條件的類型若為 text ，參數format中要將該值以單引號'包含起來 ex:NSPredicate(format: "name = '小強'")
        request.predicate =
          NSPredicate(format: "id = \(updateID)")

        /*使用do-catch語句來定義錯誤的捕獲(catch)及處理，每一個catch表示可以捕獲到一個錯誤拋出的處理方式
         do {
             try 拋出函式
             其他執行的程式
         } catch 錯誤1 {
             處理錯誤1
         } catch 錯誤2 {
             處理錯誤2
         }
        */
        do {
            //使用操作 Core Data 的常數的fetch()方法來取得資料
            //傳入參數是使用類別NSFetchRequest設置要取得的 Entity，建立一個取得資料的請求(request)
            //順利取回的資料是一個型別為[Student]的陣列
            let results =
                try myContext.fetch(request)
              as! [Student]

            //順利取得資料後，將要更新的屬性設置完畢
            if results.count > 0 {
                results[1].height = 180.7
                
                //使用操作 Core Data 的常數的save()方法來儲存更新的資料
                try myContext.save()
            }
        } catch {
            fatalError("\(error)")
        }
        
        
        //刪除資料
        //刪除資料前需要先讀取資料
        //使用類別NSFetchRequest設置要取得的 Entity，建立一個取得資料的請求(request)
        request = NSFetchRequest<NSFetchRequestResult>(entityName: myEntityName)
        
        //使用屬性predicate，設定取得資料的條件
        //每次新的查詢要設定屬性predicate前，要先將其設置為nil以清空查詢條件
        request.predicate = nil
        let deleteID = 0
        
        //查詢條件的類型若為 text ，參數format中要將該值以單引號'包含起來 ex:NSPredicate(format: "name = '小強'")
        request.predicate =
          NSPredicate(format: "id = \(deleteID)")

        /*使用do-catch語句來定義錯誤的捕獲(catch)及處理，每一個catch表示可以捕獲到一個錯誤拋出的處理方式
         do {
             try 拋出函式
             其他執行的程式
         } catch 錯誤1 {
             處理錯誤1
         } catch 錯誤2 {
             處理錯誤2
         }
        */
        do {
            //使用操作 Core Data 的常數的fetch()方法來取得資料
            //傳入參數是使用類別NSFetchRequest設置要取得的 Entity，建立一個取得資料的請求(request)
            //順利取回的資料是一個型別為[Student]的陣列
            let results =
                try myContext.fetch(request)
              as! [Student]

            for result in results {
                //順利取得資料後，使用宣吿操作 Core Data 的常數的delete()方法是來刪除資料
                myContext.delete(result)
            }
            
            //使用操作 Core Data 的常數的save()方法來儲存刪除後的資料
            try myContext.save()

        } catch {
            fatalError("\(error)")
        }
        
    }

}

