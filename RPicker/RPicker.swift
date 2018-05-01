//
//  RPicker.swift
//  RPicker
//
//  Created by rajkumar.sharma on 4/25/18.
//  Copyright © 2018 Raj Sharma. All rights reserved.
//

import UIKit

let pickerAnimationDuration: TimeInterval = 0.3
let viewTransperantTag: Int = 9099
let pickerHeight: CGFloat = 216

class RPicker: NSObject {
    
    static private let sharedInstance = RPicker()
    private var dataArray: Array<String> = []
    
    class func selectDate(title: String = "",
                          hideCancel: Bool = false,
                          datePickerMode: UIDatePickerMode = UIDatePickerMode.date,
                          selectedDate: Date? = Date(),
                          minDate: Date? = nil,
                          maxDate: Date? = nil,
                          didSelectDate : ((_ date: Date)->())?)  {
        
        if let currentController = UIWindow.currentController {
            
            if let _ = currentController.view.viewWithTag(viewTransperantTag) {
                return
            }
            
            
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = datePickerMode
            datePicker.backgroundColor = UIColor.white
            
            datePicker.minimumDate = minDate
            datePicker.maximumDate = maxDate
            
            if let selectedDate = selectedDate {
                datePicker.date = selectedDate
            } else {
                datePicker.date = Date()
            }
            
            //Screen Size
            let screenWidth = currentController.view.bounds.size.width
            let screenHeight = currentController.view.bounds.size.height
            
            // Add background view
            
            let closeFrame = CGRect(x: 0, y: screenHeight + 50, width: screenWidth, height: screenHeight)
            
            let viewTransperant = UIView()
            let view = currentController.view

            //viewTransperant.alpha = 0.0
            view?.addSubview(viewTransperant)
            viewTransperant.tag = viewTransperantTag
            view?.addBGViewConstraints(viewTransperant)
            
            // Add date picker view
            
            viewTransperant.addSubview(datePicker)
            viewTransperant.addPickerViewConstraints(datePicker)
            
            // Add tool bar with done and cancel buttons
            
            let toolBar = RToolBar()
            viewTransperant.addSubview(toolBar)
            viewTransperant.addToolBarConstraints(toolBar, -pickerHeight)
            toolBar.addToolBar(hideCancelButton: hideCancel)
            toolBar.title = title

            // show picker
            var openPickerFrame = viewTransperant.frame
            openPickerFrame.origin.y = 0
            
            UIView.animate(withDuration: pickerAnimationDuration, animations: {
                viewTransperant.frame = openPickerFrame
                
            }, completion: { (_) in
                UIView.animate(withDuration: pickerAnimationDuration, animations: {
                    viewTransperant.backgroundColor = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0.6)
                })
            })
            
            toolBar.didSelectDone = {
                didSelectDate!(datePicker.date)
                remove()
            }
            
            toolBar.didCancelled = {
                
                remove()
            }
            
            func remove() {
                
                UIView.animate(withDuration: pickerAnimationDuration, animations: {
                    viewTransperant.backgroundColor = UIColor.clear
                    
                }, completion: { (_) in
                    UIView.animate(withDuration: pickerAnimationDuration, animations: {
                        viewTransperant.frame = closeFrame
                    }, completion: { (_) in
                        viewTransperant.removeFromSuperview()
                    })
                })
            }
        }
    }
    
    class func selectOption(title: String = "",
                      hideCancel: Bool = false,
                      dataArray:Array<String>?,
                      selectedIndex: Int? = nil,
                      didSelectValue : ((_ value: String, _ atIndex: Int)->())?)  {
        
        guard let dataArray = dataArray else {
            print("Blank array")
            return
        }
        
        let picker = RPicker.sharedInstance
        
        picker.dataArray = dataArray
        
        if let currentController = UIWindow.currentController {
            
            if let bgView = currentController.view.viewWithTag(viewTransperantTag) {
                return
            }
            
            let optionPicker = UIPickerView()
            optionPicker.backgroundColor = UIColor.white
            optionPicker.dataSource = picker
            optionPicker.delegate = picker
            
            if let selectedIndex = selectedIndex {
                
                if (selectedIndex < dataArray.count) {
                    optionPicker.selectRow(selectedIndex, inComponent: 0, animated: false)
                }
            }
            
            //Screen Size
            let screenWidth = currentController.view.bounds.size.width
            let screenHeight = currentController.view.bounds.size.height
            let pickerHeight: CGFloat = 216
            
            // Add background view
            
            let closeFrame = CGRect(x: 0, y: screenHeight + 50, width: screenWidth, height: screenHeight)
            
            let viewTransperant = UIView()
            
            //viewTransperant.alpha = 0.0
            currentController.view.addSubview(viewTransperant)
            let view = currentController.view
            viewTransperant.tag = viewTransperantTag
            view?.addBGViewConstraints(viewTransperant)
            
            // Add date picker view
            
            viewTransperant.addSubview(optionPicker)
            viewTransperant.addPickerViewConstraints(optionPicker)

            // Add tool bar with done and cancel buttons
            
            let toolBar = RToolBar()
            viewTransperant.addSubview(toolBar)
            viewTransperant.addToolBarConstraints(toolBar, -pickerHeight)
            toolBar.addToolBar(hideCancelButton: hideCancel)
            toolBar.title = title

            // show picker
            var openPickerFrame = viewTransperant.frame
            openPickerFrame.origin.y = 0
            
            UIView.animate(withDuration: pickerAnimationDuration, animations: {
                viewTransperant.frame = openPickerFrame
                
            }, completion: { (_) in
                UIView.animate(withDuration: pickerAnimationDuration, animations: {
                    viewTransperant.backgroundColor = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0.6)
                })
            })
            
            toolBar.didSelectDone = {
                
                if let block = didSelectValue {
                    
                    let selectedValueIndex = optionPicker.selectedRow(inComponent: 0)
                    
                    block(dataArray[selectedValueIndex], selectedValueIndex)
                }
                remove()
            }
            
            toolBar.didCancelled = {
                
                remove()
            }
            
            func remove() {
                
                UIView.animate(withDuration: pickerAnimationDuration, animations: {
                    viewTransperant.backgroundColor = UIColor.clear
                    
                }, completion: { (_) in
                    UIView.animate(withDuration: pickerAnimationDuration, animations: {
                        viewTransperant.frame = closeFrame
                    }, completion: { (_) in
                        viewTransperant.removeFromSuperview()
                    })
                })
            }
        }
    }
}

extension RPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    //function for the number of columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //function counting the array to give the number of rows in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    //function displaying the array rows in the picker as a string
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
}

class RToolBar: UIView {
    
    open var didSelectDone: (() -> Void)?
    open var didCancelled: (() -> Void)?
    
    var toolBarTitleItem: ToolBarTitleItem?

    private var hideCancelButton: Bool = false
    
    var title = "" {
        didSet {
            guard let toolBarTitleItem = toolBarTitleItem else {
                return
            }
             
            toolBarTitleItem.label.text = title
        }
    }
    
    func addToolBar(hideCancelButton: Bool = false) {
        self.hideCancelButton = hideCancelButton
        let toolbarL = toolbar
        self.addSubview(toolbarL)
        self.addToolBarConstraints(toolbarL)
    }
    
    open var toolbar: UIToolbar {
        
        let toolBarL = ToolBar(frame: frame, target: self)

        if !hideCancelButton {
            toolBarL.appendButton(buttonItem: toolBarL.buttonItem(systemItem: .cancel, selector: #selector(self.cancelAction)))
        }
        
        //toolBar.appendButton(buttonItem: toolBar.buttonItem(systemItem: .camera, selector: #selector(self.doneAction)))
        toolBarL.appendButton(buttonItem: toolBarL.flexibleSpace)
        
        let toolBarTitleItem = toolBarL.titleItem(text: "", font: UIFont(name: "HelveticaNeue-Medium", size: 15.0)!, color: UIColor.black)
        
        self.toolBarTitleItem = toolBarTitleItem as? ToolBarTitleItem
        toolBarL.appendButton(buttonItem: toolBarTitleItem)
        toolBarL.appendButton(buttonItem: toolBarL.flexibleSpace)
        toolBarL.appendButton(buttonItem: toolBarL.buttonItem(systemItem: .done, selector: #selector(self.doneAction)))

        return toolBarL
    }
    
    @objc func doneAction() {
        didSelectDone?()
    }
    
    @objc func cancelAction() {
        
        if !hideCancelButton {
            didCancelled?()
        }
    }
}

class ToolBar: UIToolbar {
    
    let target: Any?
    
    init(frame: CGRect, target: Any?) {
        self.target = target
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonItem(systemItem: UIBarButtonSystemItem, selector: Selector?) -> UIBarButtonItem {
        
        return UIBarButtonItem(barButtonSystemItem: systemItem, target: target, action: selector)
    }
    
    var flexibleSpace: UIBarButtonItem {
        return buttonItem(systemItem: UIBarButtonSystemItem.flexibleSpace, selector:nil)
    }
    
    func titleItem (text: String, font: UIFont, color: UIColor) -> UIBarButtonItem {
        return ToolBarTitleItem(text: text, font: font, color: color)
    }
    
    func appendButton(buttonItem: UIBarButtonItem) {
        if items == nil {
            items = [UIBarButtonItem]()
        }
        
        buttonItem.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 14.0)!,
            NSAttributedStringKey.foregroundColor: UIColor(red: (49/255.0), green: (118/255.0), blue: 239, alpha: 1)],
                                          for: .normal)
        
        items!.append(buttonItem)
    }
}

class ToolBarTitleItem: UIBarButtonItem {
    
    var label: UILabel
    
    init(text: String, font: UIFont, color: UIColor) {
        
        var frame = UIScreen.main.bounds
        frame.size.width = UIScreen.main.bounds.width - 140
        
        label =  UILabel(frame: frame)
        label.text = text
        //label.sizeToFit()
        label.font = font
        label.textColor = color
        label.textAlignment = .center
        label.numberOfLines = 0
        
        super.init()

        customView = label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIWindow {
    
    static var currentController: UIViewController? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.window?.currentController
    }
    
    var currentController: UIViewController? {
        if let vc = self.rootViewController {
            return topViewController(controller: vc)
        }
        return nil
    }
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nc = controller as? UINavigationController {
            if nc.viewControllers.count > 0 {
                return topViewController(controller: nc.viewControllers.last!)
            } else {
                return nc
            }
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UIView {
    
    func addBGViewConstraints(_ relativeToView: UIView) {
        
        relativeToView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func addPickerViewConstraints(_ relativeToView: UIView) {
        
        relativeToView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.bottomMargin, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: pickerHeight)
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func addToolBarConstraints(_ relativeToView: UIView,_ bottomConst: CGFloat = 0) {
        
        relativeToView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.bottomMargin, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: bottomConst)
        let widthConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: relativeToView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 48)
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}
