//
//  ViewController.swift
//  RPicker
//
//  Created by rajkumar.sharma on 4/25/18.
//  Copyright © 2018 Raj Sharma. All rights reserved.
//

import UIKit

let dummyList = ["Apple", "Orange", "Banana", "Mango", "Bilberry", "Blackberry"]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var outputLabel: UILabel!
    
    let items = ["Show date picker", "Show date picker with tile", "Show time picker", "Show date and time picker", "Show date picker with min and max date", "Show option picker", "Show option picker with selected index"]
    
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
            
            RPicker.selectDate { (selectedDate) in
                // TODO: Your implementation for date
                self.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            }
          
        case 1:
            
            RPicker.selectDate(title: "Select Date", didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
                self.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            })
            
        case 2:

            RPicker.selectDate(title: "Select Time", datePickerMode: .time, didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
                self.outputLabel.text = selectedDate.dateString("hh:mm a")
            })
           
        case 3:
            
            RPicker.selectDate(title: "Select Date & Time", datePickerMode: .dateAndTime, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
                self.outputLabel.text = selectedDate.dateString()
            })
            
        case 4:
            
            RPicker.selectDate(title: "Select Date", hideCancel: true, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
                self.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            })
            
        case 5:
            
            RPicker.selectOption(dataArray: dummyList) { (selctedText, atIndex) in
                // TODO: Your implementation for selection
                self.outputLabel.text = selctedText + " selcted at \(atIndex)"
            }
            
        case 6:
            
            RPicker.selectOption(title: "Select", hideCancel: true, dataArray: dummyList, selectedIndex: 2) { (selctedText, atIndex) in
                // TODO: Your implementation for selection
                self.outputLabel.text = selctedText + " selcted at \(atIndex)"
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

