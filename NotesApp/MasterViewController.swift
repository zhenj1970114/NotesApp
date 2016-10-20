//
//  MasterViewController.swift
//  NotesApp
//
//  Created by Jia Zheng on 10/17/16.
//  Copyright © 2016 Jia Zheng. All rights reserved.
//

import UIKit

var objects:[String] = [String]()
var currentIndex:Int = 0
var masterView: MasterViewController?
//same as the class we are working in right now 
var detailViewController:DetailViewController?

let kNotes:String = "notes"
let BLANK_NOTE:String = "(New Note)"


class MasterViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        masterView = self
        load()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        save()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        if objects.count == 0 || objects[0]  != BLANK_NOTE {
        objects.insert(BLANK_NOTE, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        currentIndex = 0
        
        //everytime we create a note, it's at the top, so it's 0
        self.performSegue(withIdentifier: "showDetail", sender: self)
        //go into editing screen when hit the plus sign
        
    }
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                currentIndex = indexPath.row
                
                 //how to change this the left part to a string?
                //detailViewController?.detailItem = object
                detailViewController?.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
               detailViewController?.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    //from professor
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        detailViewController?.detailDescriptionLabel.isEditable = true
//        
//        
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                currentIndex = indexPath.row
//            }
//            
//            let object: String = objects[currentIndex]
//            
//            detailViewController?.detailItem = object
//            detailViewController?.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
//            detailViewController?.navigationItem.leftItemsSupplementBackButton = true
//            
//        }
//    }
    
    
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func save(){
        
        //old version is:
        //NSUserDefaults.standardUserDefaults().setObject(objects,forKey:kNoes)
        UserDefaults.standard.set(objects,forKey:kNotes)
        UserDefaults.standard.synchronize()
        //save the data to persistent storage?
        
        
    
    }

    func load(){
        if let loadedData = UserDefaults.standard.array(forKey: kNotes)as?[String]{
            objects = loadedData
            
        }
    
    }
}



















