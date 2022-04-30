# RPicker
Elegant and Easy-to-Use Swift Date and Options Picker.
Master branch has the latest code and compatible with Swift 5. Check other branches for various Swift versions

# What's New
* iOS 14 Support with various UIDatePickerStyle e.g. Wheel, Inline, Compact
* Dark Mode and Light Mode Support
* Objective C Support [See How to use in Objective C Heading of this file]

![Alt text](https://github.com/rheyansh/RPicker/blob/master/Screenshots/1.png)
![Alt text](https://github.com/rheyansh/RPicker/blob/master/Screenshots/2.png)
![Alt text](https://github.com/rheyansh/RPicker/blob/master/Screenshots/3.png)
![Alt text](https://github.com/rheyansh/RPicker/blob/master/Screenshots/4.png)

# How to use
Add RPicker.swift into your project.
You are ready to go!

    // Simple Date Picker
        RPicker.selectDate {[weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
        }
        
        // Simple Date Picker with title
        RPicker.selectDate(title: "Select Date", didSelectDate: {[weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
        })
        
        // Simple Time Picker
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { [weak self](selectedDate) in
            // TODO: Your implementation for date
            self?.outputLabel.text = selectedDate.dateString("hh:mm a")
        })
        
        // Simple Date and Time Picker
        RPicker.selectDate(title: "Select Date & Time", cancelText: "Cancel", datePickerMode: .dateAndTime, minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: {[weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.outputLabel.text = selectedDate.dateString()
        })
        
        //Show date picker with min and max date
        RPicker.selectDate(title: "Select Date", minDate: Date(), maxDate: Date().dateByAddingYears(5), didSelectDate: {[weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
        })
        
        // Simple Option Picker
        let dummyList = ["Apple", "Orange", "Banana", "Mango", "Bilberry", "Blackberry"]

        RPicker.selectOption(dataArray: dummyList) {[weak self] (selctedText, atIndex) in
            // TODO: Your implementation for selection
            self?.outputLabel.text = selctedText + " selcted at \(atIndex)"
        }
        
        // Simple Option Picker with selected index
        let dummyList = ["Apple", "Orange", "Banana", "Mango"]
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 2) {[weak self] (selctedText, atIndex) in
            // TODO: Your implementation for selection
            self?.outputLabel.text = selctedText + " selcted at \(atIndex)"
        }
        
        //Date picker with pre selected date
        let selectedDate = Date().dateByAddingYears(-6)
        let maxDate = Date()
        let minDate = Date().dateByAddingYears(-12)
        
        RPicker.selectDate(title: "Select", selectedDate: selectedDate, minDate: minDate, maxDate: maxDate) { [weak self] (selectedDate) in
            // TODO: Your implementation for date
            self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            
        }
        
       //Show date picker iOS 14 -> Inline mode
            RPicker.selectDate(title: "Select Date", cancelText: "Cancel", datePickerMode: .date, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString("MMM-dd-YYYY")
            })
            
            //Show time picker iOS 14 -> Inline mode
            RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString("hh:mm a")
            })
            
            //Show date and time picker iOS 14 -> Inline mode
            RPicker.selectDate(title: "Select Date and Time", cancelText: "Cancel", datePickerMode: .dateAndTime, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString()
            })
            
            //Show date and time picker iOS 14 -> Compact mode
            RPicker.selectDate(title: "Select Date and Time", cancelText: "Cancel", datePickerMode: .dateAndTime, style: .Compact, didSelectDate: {[weak self] (selectedDate) in
                // TODO: Your implementation for date
                self?.outputLabel.text = selectedDate.dateString()
            })
        

# How to use in Objective C
**Date Picker**

    [RPicker selectDateWithTitle:@"Select" cancelText:@"Cancel" doneText:@"Done" datePickerMode:UIDatePickerModeDate selectedDate:dateValue minDate:nil maxDate:nil style: RDatePickerStyleWheel didSelectDate:^(NSDate * _Nonnull date) {
       
    }];
     
**Option Picker**

         NSArray *list = @[@"Banana", @"Apple", @"Orange"];
         
         [RPicker pickOptionWithTitle:@"Select" cancelText:@"Cancel" doneText:@"Done" dataArray:list selectedIndex:[NSNumber numberWithInt:2] didSelectValue:^(NSString * _Nonnull value, NSInteger index) {
            
         }];

# Author   

* [Raj Sharma](https://github.com/rheyansh)

## Communication

* If you **found a bug**, open an issue.
* If you **want to contribute**, submit a pull request.

# License
RPicker is available under the MIT license. See the LICENSE file for more info.
