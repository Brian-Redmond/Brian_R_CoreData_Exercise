//
//  ViewController.swift
//  Core Data
//
//  Created by Brian Redmond on 8/13/20.
//  Copyright © 2020 Brian Redmond. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {

    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    @IBAction func saveRecord(_ sender: UIButton) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName:"Item", into: dataManager)
        newEntity.setValue(Violinthoughts.text!, forKey: "about")
            do{
            try self.dataManager.save()
            listArray.append(newEntity)
        }catch{
            print ("Error saving data")
        }
        displaytext.text?.removeAll()
        Violinthoughts.text?.removeAll()
        fetchData()
    }
    
    @IBAction func deleteRecord( sender: UIButton) {
        let deleteItem = Violinthoughts.text!
        for item in listArray {
            if item.value(forKey:"about") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            } catch {
                print ("Error getting rid of data")
            }
            displaytext.text?.removeAll()
            Violinthoughts.text?.removeAll()
            fetchData()
        }
        
    }
    
    @IBOutlet var Violinthoughts: UITextField!
    
    @IBOutlet var displaytext:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let appDelegate = UIApplication.shared.delegate as!AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        displaytext.text?.removeAll()
        fetchData()
    }
    
    func fetchData() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                
                let product = item.value(forKey: "about") as! String
                displaytext.text! += product
                
            }
        }catch{
        print("Error getting data")
            
           
                
            }
        }
    }




