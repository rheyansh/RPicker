//
//  ViewController.swift
//  RPicker
//
//  Created by Raj Sharma on 23/10/19.
//  Copyright © 2019 Raj Sharma. All rights reserved.
//

import UIKit

let dummyList = ["Apple", "Orange", "Banana", "Mango", "Bilberry", "Blackberry"]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var outputLabel: UILabel!
    
    let items = ["Show date picker", "Show date picker with tile", "Show time picker", "Show date and time picker", "Show date picker with min and max date", "Show option picker", "Show option picker with selected index", "Show date picker with pre selected date"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK:- UITableViewDelegate/UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            
            // Simple Date Picker
            RPicker.selectDate {[weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            }
            
        case 1:
            
            // Simple Date Picker with title
            RPicker.selectDate(title: "Select Date", didSelectDate: {[weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            })
            
        case 2:
            
            // Simple Time Picker
            RPicker.selectDate(title: "Select Time", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString("hh:mm a")
            })
            
        case 3:
            
            // Simple Date and Time Picker
            RPicker.selectDate(title: "Select Date & Time", datePickerMode: .dateAndTime, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: {[weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString()
            })
            
        case 4:
            //Show date picker with min and max date
            RPicker.selectDate(title: "Select Date", hideCancel: true, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: {[weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            })
            
        case 5:
            
            // Simple Option Picker
            RPicker.selectOption(dataArray: dummyList) {[weak self] (selctedText, atIndex) in
                // TODO: Your implementation for selection
                self?.outputLabel.text = selctedText + " selcted at \(atIndex)"
            }
            
        case 6:
            
            // Simple Option Picker with selected index
            let dummyList = ["Apple", "Orange", "Banana", "Mango"]
            RPicker.selectOption(title: "Select", hideCancel: true, dataArray: dummyList, selectedIndex: 2) {[weak self] (selctedText, atIndex) in
                // TODO: Your implementation for selection
                self?.outputLabel.text = selctedText + " selcted at \(atIndex)"
            }
            
        case 7:
            
            //Date picker with pre selected date
            let selectedDate = Date().dateByAddingYears(-6)
            let maxDate = Date()
            let minDate = Date().dateByAddingYears(-12)
            
            RPicker.selectDate(title: "Select", selectedDate: selectedDate, minDate: minDate, maxDate: maxDate) { [weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
                
            }
            
        default:
            break
        }
        
    }
    
}


extension Date {
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}





