//
//  ListTableVC.swift
//  ToDo List
//
//  Created by Ryan Kistner on 1/18/18.
//  Copyright © 2018 Ryan Kistner. All rights reserved.
//

import UIKit
import CoreData

class ListTableVC: UITableViewController, AddItemToListDelegate {

    var labelText = [String]()
    var dateArray  = [Date]()
    var infoDesc = [String]()
    var coreDataHolder = [ToDoInfo]()
    
    let formatter = DateFormatter()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchAllItems()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddItemVC
        destination.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coreDataHolder.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.cellTitle.text = coreDataHolder[indexPath.row].title
        cell.cellDescription.text = coreDataHolder[indexPath.row].desc
        formatter.dateStyle = .medium
        cell.cellDate.text = formatter.string(from: coreDataHolder[indexPath.row].date!)
        cell.accessoryType = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    func addItemToList(title: String, descirption: String, date: Date) {
        let addItem = NSEntityDescription.insertNewObject(forEntityName: "ToDoInfo", into: managedObjectContext) as! ToDoInfo
            addItem.title = title
            addItem.desc = descirption
            addItem.date = date
            
        do {
            try managedObjectContext.save()
        }catch{
            print("\(error)")
        }
    }
    
    func fetchAllItems(){
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoInfo")
            do {
                let results = try managedObjectContext.fetch(request)
                coreDataHolder = results as! [ToDoInfo]
            } catch {
                print ("\(error)")
            }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = coreDataHolder[indexPath.row]
        managedObjectContext.delete(item)
        do{
            try managedObjectContext.save()
        }catch{
            print("\(error)")
        }
        coreDataHolder.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}
