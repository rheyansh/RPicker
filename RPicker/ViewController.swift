//
//  ViewController.swift
//  RPicker
//
//  Created by rajkumar.sharma on 4/25/18.
//  Copyright © 2018 Raj Sharma. All rights reserved.
//

import UIKit

let dummyList = ["Apple", "Orange", "Banana", "Mango"]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var outputLabel: UILabel!
    
    let items = ["Show date picker", "Show date picker with tile", "Show time picker", "Show date picker with min and max date", "Show option picker", "Show option picker with selected index"]
    
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
                self.outputLabel.text = selectedDate.dateString()
            }
          
        case 1:
            
            RPicker.selectDate(title: "Select Date", didSelectDate: { (selectedDate) in
                self.outputLabel.text = selectedDate.dateString()
            })
            
        case 2:

            RPicker.selectDate(title: "Select Time", datePickerMode: .time, didSelectDate: { (selectedDate) in
                self.outputLabel.text = selectedDate.timeString()
            })
            
        case 3:
            
            RPicker.selectDate(title: "Select Date", hideCancel: true, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: { (selectedDate) in
                self.outputLabel.text = selectedDate.dateString()
            })
            
        case 4:
            
            RPicker.selectOption(dataArray: dummyList) { (selctedText, atIndex) in
                self.outputLabel.text = selctedText + " selcted at \(atIndex)"
            }
            
        case 5:
            
            RPicker.selectOption(title: "Select", hideCancel: true, dataArray: dummyList, selectedIndex: 2) { (selctedText, atIndex) in
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
    
    func timeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: self)
    }
}

