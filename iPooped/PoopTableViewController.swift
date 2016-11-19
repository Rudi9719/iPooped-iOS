//
//  PoopTableViewController.swift
//  iPooped
//
//  Created by Gregory Rudolph-Alverson on 11/9/16.
//  Copyright © 2016 STEiN-Net. All rights reserved.
//

import UIKit

class PoopTableViewController: UITableViewController {
    var poops = [Poop]()
    
    let poopRates = ["Awesome", "Good", "Okay", "Average", "Eh", "Meh",
                      "Shitty", "Wtf", "Oh shit", "Call 911"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Poop table loaded")
        
        if let savedPoops = loadPoops() {
            poops += savedPoops
            print("Poops loaded.")
       
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func loadPoops() -> [Poop]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Poop.ArchiveURL.path) as? [Poop]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindHome(segue: UIStoryboardSegue) {
        print("Unwinding home")
        if let sourceViewController = segue.source as? ViewController {
            let smelly  = sourceViewController.smelly!
                // Add a new meal.
                let newIndexPath = IndexPath(row: 0, section: 0)
                poops.insert(smelly, at: 0)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            

            
        
            
        }
        if let sourceViewController = segue.source as? PoopDetailViewController {
            if let smelly  = sourceViewController.smelly {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    
                    poops[selectedIndexPath.row] = smelly
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            } else {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    poops.remove(at: selectedIndexPath.row)
                    tableView.deleteRows(at: [selectedIndexPath], with: .none)
                   
                }
                
            }
            
            
        }
            savePoos()
    }
    func savePoos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(poops, toFile: Poop.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save poop...")
        }
        if isSuccessfulSave {
            print("Poos saved")
            
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poops.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PTVCell", for: indexPath) as! PoopTableViewCell
        let poop = poops[indexPath.row]
        
        cell.dateTime.text = poop.datetime
        cell.rating.text = poopRates[poop.rate]
        
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        if segue.identifier == "NewPoop" {
            
        }
        else if segue.identifier == "ShowPoopDetail" {
            let poopDetailController = segue.destination as! PoopDetailViewController
            // Get the cell that generated this segue.
            if let selectedPoopCell = sender as? PoopTableViewCell {
                let indexPath = tableView.indexPath(for: selectedPoopCell)!
                let selectedPoop = poops[indexPath.row]
                poopDetailController.smelly = selectedPoop
            }
        }
    }
 

}
