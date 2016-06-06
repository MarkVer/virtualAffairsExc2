//
//  TableViewController.swift
//  VirtualAffairsExc2
//
//  Created by Mark Verwoerd on 06/06/16.
//  Copyright © 2016 Mark Verwoerd. All rights reserved.
//

import Foundation
import UIKit


// Make this viewController conform to our DatePickerDelegate delegate.
class TableViewController: UITableViewController, DatePickerDelegate {
    
    // Properties to hold the value that is sent back from ddateController.
    var beginDateFromDateController:String?
    var endDateFromDateController:String?
    
    // Instance of our Date class.
    var currentEntry: Date?
    
    // Array to hold our Date objects.
    var allDates:[Date] = []
    
    // MARK: - Add new entry action.
    
    @IBAction func addNewEntry(sender: AnyObject) {
        let datePickerVC = self.storyboard?.instantiateViewControllerWithIdentifier("DateController") as! DateController
        
        // Set self as value to the delegate.
        datePickerVC.delegate = self
        self.navigationController!.pushViewController(datePickerVC, animated: true)
    }
   
    
    // MARK: - ViewWillAppear.
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        
    }
    
    // MARK: - Numbers of rows in section.
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allDates.count
    }
    
    // MARK: - Cell for row at indexPath.
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell",
                                                               forIndexPath: indexPath) as! customCell
        let dateEntry = allDates[indexPath.row]
        
        cell.beginDateValue.text = dateEntry.beginDate
        cell.endDateValue.text = dateEntry.endDate
        
        return cell
    }
    
    // MARK: - Commit editing style.
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        
        // If the table view is asking to commit a delete command...
        if editingStyle == .Delete {
            
            let entry = allDates[indexPath.row]
            
            // Remove entry from allDates
            self.removeEntry(entry)
            
            // Also remove that row from the table view with an animation
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        }
    }
    
    // MARK: - Title for delete confirmation button.
    
    // Function to change the name of the delete button in the cell.
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Remove"
    }
    
    // MARK: - Prepare for segue.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If the triggered segue is the "ShowItem" segue
        if segue.identifier == "ShowItem" {
            
            // Figure out which row was just tapped.
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get the item associated with this row and pass it along.
                let dateEntry = allDates[row]
                let dateControllerVC = segue.destinationViewController as! DateController
                dateControllerVC.dateEntry = dateEntry
            }
        }
    }
    
    // MARK: - Set new entry function.
    
    // Implement the required function to make this viewController confirm to the protocol.
    func setNewEntryFor(beginDate: String, endDate: String) {
        self.beginDateFromDateController = beginDate
        self.endDateFromDateController = endDate
        addNewDateEntry()
        
    }
    
    // MARK: - Add new date entry.
    
    // Function to add a Date object to the allDates array.
    func addNewDateEntry() -> Date {
        
        let newDate = Date(beginDate: self.beginDateFromDateController!, endDate: self.endDateFromDateController!)
        allDates.append(newDate)
        
        return newDate
    }
    
    // MARK: - Remove selected date entry.
    
    // Function to remove a Date object to the allDates array.
    func removeEntry(entry: Date) {
        if let index = allDates.indexOf(entry) {
            allDates.removeAtIndex(index)
        }
    }
    
}
