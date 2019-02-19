//
//  ViewController.swift
//  TodoEdy
//
//  Created by Eddie Ortega on 2/10/19.
//  Copyright © 2019 Ortegalive Software. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let defaults = UserDefaults.standard
    // Declare intance variables here
    
    // Declare linked IBOulets
    @IBOutlet var todoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(dataFilePath)
        
        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]
//        {
//            itemArray = items
//        }
    }
    
    //MARK - Tableview Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row]
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }else {
//            itemArray[indexPath.row].done = false
//        }
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new Items
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDO Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: UIAlertAction.Style.default) { (action) in
            // What should happend once the user clicks the add item button on our UIAlert
            print("Success!")
            print(textField)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
            print("Now")
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    func saveItems() {
        
        // IMPORTANT NOTE: Because item array is an array of our custom item object then this line fails.
        //                 Insted we are going to use an <Encoder> type property list encoder.
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
        let encoder = PropertyListEncoder()
        //                 <encode> method can throw an error. That's why need a TRY CATCH block.
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
            
        }
        
    }

}

