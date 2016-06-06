//
//  DateController.swift
//  VirtualAffairsExc2
//
//  Created by Mark Verwoerd on 06/06/16.
//  Copyright © 2016 Mark Verwoerd. All rights reserved.
//

import UIKit

// Protocol for passing the data backwards.
protocol DatePickerDelegate {
    
    func setNewEntryFor(beginDate:String, endDate:String)
}

class DateController: UIViewController {
    
    // Days to add to current date.
    var daysToAdd = 7
    
    // Delagate for sending data backwards.
    var delegate:DatePickerDelegate?
    
    // Instance of our Date class.
    var dateEntry:Date?
    
    // MARK: - Outlets
    
    @IBOutlet var DatePicker: UIDatePicker!
    @IBOutlet var beginDate: UILabel!
    @IBOutlet var endDate: UILabel!
    
    // MARK: - Clear button.
    
    @IBAction func clearButton(sender: AnyObject) {
        
        DatePicker.date = NSDate()
        datePicker(DatePicker)
        
    }
    
    // MARK: - Date formatter.
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    // MARK: - Datepicker function.
    
    func datePicker (datePicker: UIDatePicker) {
        
        // Convert the date to a String
        let dateValue = dateFormatter.stringFromDate(datePicker.date)
        
        // Add 7 days to datePicker.date
        let calculatedDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: daysToAdd, toDate: datePicker.date, options: NSCalendarOptions.init(rawValue: 0))
        let dateValueEnd = dateFormatter.stringFromDate(calculatedDate!)
        
        // Update the values of the labels
        beginDate.text = dateValue
        endDate.text = dateValueEnd
        
    }
    
    // MARK: - ViewDidLoad.
    
    override func viewDidLoad() {
        
        // Check if the instance has a value. If yes, set it's values to the labels and the datepicker property.
        if dateEntry != nil {
            
            beginDate.text = dateEntry?.beginDate
            endDate.text = dateEntry?.endDate
            DatePicker.date = dateFormatter.dateFromString((dateEntry?.beginDate)!)!
            
        } else {
            
            // Call the datePiker function.
            datePicker(DatePicker)
        }
        
        // Minimum date must be current date
        DatePicker.minimumDate = NSDate()
        
        // Display date from datepicker
        DatePicker.addTarget(self, action: #selector(DateController.datePicker),forControlEvents:UIControlEvents.ValueChanged)
        
    }
    
    // MARK: - ViewWillAppear.
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - ViewWillDissapear.
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.setNewEntryFor(self.beginDate.text!, endDate:self.endDate.text!)
        
        dateEntry?.beginDate = beginDate.text!
        dateEntry?.endDate = endDate.text!
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

