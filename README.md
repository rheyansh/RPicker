# RPicker
Elegant and Easy-to-Use iOS Swift Date and Options Picker

# How to use
Add RPicker.swift into your project.
You are ready to go!

    // Simple Date Picker
    RPicker.selectDate { (selectedDate) in
                // TODO: Your implementation for date
            }            
    
    // Simple Date Picker with title
    RPicker.selectDate(title: "Select Date", didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
            })
            
    // Simple Date Picker with min and max validation
    RPicker.selectDate(title: "Select Date", hideCancel: true, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
            })      
    
    // Simple Time Picker
    RPicker.selectDate(title: "Select Time", datePickerMode: .time, didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
            })
    
    // Simple Date and Time Picker
    RPicker.selectDate(title: "Select Date & Time", datePickerMode: .dateAndTime, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
            })
            
    // Simple Option Picker
    let dummyList = ["Apple", "Orange", "Banana", "Mango"]
    RPicker.selectOption(dataArray: dummyList) { (selctedText, atIndex) in
                // TODO: Your implementation for selection
            }
            
    // Simple Option Picker with selected index
    RPicker.selectOption(title: "Select", hideCancel: true, dataArray: dummyList, selectedIndex: 2) { (selctedText, atIndex) in
                // TODO: Your implementation for selection
            }
# Author   
Raj Sharma, link.rajsharma@gmail.com

# License
RPicker is available under the MIT license. See the LICENSE file for more info.
