//
//  RPicker.swift
//  RPicker
//
//  Created by rajkumar.sharma on 4/25/18.
//  Copyright © 2018 Raj Sharma. All rights reserved.
//

import UIKit

enum RPickerType {
    case date, option
}

open class RPicker {
    
    private static let sharedInstance = RPicker()
    private var isPresented = false
    
    /**
     Show UIDatePicker with various constraints.
     
     - Parameters:
     - title: Title visible to user above UIDatePicker.
     - cancelText: By default button is hidden. Set text to show cancel button.
     - doneText: Set done button title customization. A default title "Done" is used.
     - datePickerMode: default is Date.
     - selectedDate: default is current date.
     - minDate: default is nil.
     - maxDate: default is nil.

     - returns: closure with selected date.
     */
    
    class func selectDate(title: String? = nil,
                          cancelText: String? = nil,
                          doneText: String = "Done",
                          datePickerMode: UIDatePicker.Mode = .date,
                          selectedDate: Date = Date(),
                          minDate: Date? = nil,
                          maxDate: Date? = nil,
                          didSelectDate : ((_ date: Date)->())?) {
        
        guard let vc = controller(title: title, cancelText: cancelText, doneText: doneText, datePickerMode: datePickerMode, selectedDate: selectedDate, minDate: minDate, maxDate: maxDate, type: .date) else { return }
        
        vc.onDateSelected = { (selectedData) in
            didSelectDate?(selectedData)
        }
    }
    
    /**
    Show UIDatePicker with various constraints.
    
    - Parameters:
    - title: Title visible to user above UIDatePicker.
    - cancelText: By default button is hidden. Set text to show cancel button.
    - doneText: Set done button title customization. A default title "Done" is used.
    - dataArray: Array of string items.
    - selectedIndex: default is nil. If set then picker will show selected index

    - returns: closure with selected text and index.
    */
    
    class func selectOption(title: String? = nil,
                            cancelText: String? = nil,
                            doneText: String = "Done",
                            dataArray: Array<String>?,
                            selectedIndex: Int? = nil,
                            didSelectValue : ((_ value: String, _ atIndex: Int)->())?)  {
        
        guard let arr = dataArray, let vc = controller(title: title, cancelText: cancelText, doneText: doneText, dataArray: arr, selectedIndex: selectedIndex, type: .option) else { return }
        
        vc.onOptionSelected = { (selectedValue, selectedIndex) in
            didSelectValue?(selectedValue, selectedIndex)
        }
    }
    
    private class func controller(title: String? = nil,
                          cancelText: String? = nil,
                          doneText: String = "Done",
                          datePickerMode: UIDatePicker.Mode = .date,
                          selectedDate: Date = Date(),
                          minDate: Date? = nil,
                          maxDate: Date? = nil,
                          dataArray:Array<String> = [],
                          selectedIndex: Int? = nil,
                          type: RPickerType = .date) -> RPickerController? {
        
        
        if let cc = UIWindow.currentController {
            if RPicker.sharedInstance.isPresented == false {
                RPicker.sharedInstance.isPresented = true
                
                let vc = RPickerController(title: title, cancelText: cancelText, doneText: doneText, datePickerMode: datePickerMode, selectedDate: selectedDate, minDate: minDate, maxDate: maxDate, dataArray: dataArray, selectedIndex: selectedIndex, type: type)
                
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                cc.present(vc, animated: true, completion: nil)
                
                vc.onWillDismiss = {
                    RPicker.sharedInstance.isPresented = false
                }
                
                return vc
            }
        }
        
        return nil
    }
}

private extension UIView {
    
    func pinConstraints(_ byView: UIView, left: CGFloat? = nil, right: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil, height: CGFloat? = nil, width: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let l = left { leftAnchor.constraint(equalTo: byView.leftAnchor, constant: l).isActive = true }
        if let r = right { rightAnchor.constraint(equalTo: byView.rightAnchor, constant: r).isActive = true }
        if let t = top { topAnchor.constraint(equalTo: byView.topAnchor, constant: t).isActive = true }
        if let b = bottom { bottomAnchor.constraint(equalTo: byView.bottomAnchor, constant: b).isActive = true }
        if let h = height { heightAnchor.constraint(equalToConstant: h).isActive = true }
        if let w = width { widthAnchor.constraint(equalToConstant: w).isActive = true }
    }
    
    func surroundConstraints(_ byView: UIView, left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        pinConstraints(byView, left: left, right: right, top: top, bottom: bottom)
    }
}

class RPickerController: UIViewController {
    
    //MARK:- Public closuers
    var onDateSelected : ((_ date: Date) -> Void)?
    var onOptionSelected : ((_ value: String, _ atIndex: Int) -> Void)?
    var onWillDismiss : (() -> Void)?

    //MARK:- Public variables
    var selectedIndex: Int?
    var selectedDate = Date()
    var maxDate: Date?
    var minDate: Date?
    var titleText: String?
    var cancelText: String?
    var doneText: String = "Done"
    var datePickerMode: UIDatePicker.Mode = .date
    var pickerType: RPickerType = .date
    var dataArray: Array<String> = []
    
    //MARK:- Private variables
    private let barViewHeight: CGFloat = 44
    private let pickerHeight: CGFloat = 216
    private let buttonWidth: CGFloat = 84
    private let lineHeight: CGFloat = 0.5
    private let buttonColor = UIColor(red: 72/255, green: 152/255, blue: 240/255, alpha: 1)
    private let lineColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    private let barViewBGColor = UIColor.white
    
    //MARK:- Init
    init(title: String? = nil,
         cancelText: String? = nil,
         doneText: String = "Done",
         datePickerMode: UIDatePicker.Mode = .date,
         selectedDate: Date = Date(),
         minDate: Date? = nil,
         maxDate: Date? = nil,
         dataArray:Array<String> = [],
         selectedIndex: Int? = nil,
         type: RPickerType = .date) {
        
        self.titleText = title
        self.cancelText = cancelText
        self.doneText = doneText
        self.datePickerMode = datePickerMode
        self.selectedDate = selectedDate
        self.minDate = minDate
        self.maxDate = maxDate
        self.dataArray = dataArray
        self.selectedIndex = selectedIndex
        self.pickerType = type
        
        super.init(nibName: nil, bundle: nil)
        
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private functions
    private func initialSetup() {
        
        view.backgroundColor = UIColor.clear
        let bgView = UIView()
        view.addSubview(bgView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        bgView.addGestureRecognizer(tapGesture)
        
        bgView.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        bgView.isUserInteractionEnabled = true
        bgView.surroundConstraints(view)
        
        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 0.0
        
        stackView.addArrangedSubview(lineLabel)
        stackView.addArrangedSubview(toolBarView)
        stackView.addArrangedSubview(lineLabel)
        
        if pickerType == .date {
            stackView.addArrangedSubview(datePicker)
        } else {
            stackView.addArrangedSubview(optionPicker)
        }
        
        self.view.addSubview(stackView)
        
        let height = barViewHeight + pickerHeight + (2*lineHeight)
        stackView.pinConstraints(view, left: 0, right: 0, bottom: 0, height: height)
    }
    
    private func dismissVC() {
        onWillDismiss?()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap() { dismissVC() }
    
    //MARK:- Private properties

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = UIColor.white
        picker.pinConstraints(view, width: view.frame.width)
        picker.minimumDate = minDate
        picker.maximumDate = maxDate
        picker.date = selectedDate
        picker.datePickerMode = datePickerMode

        return picker
    }()
    
    private lazy var optionPicker: UIPickerView = {
        
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.pinConstraints(view, width: view.frame.width)
        
        if let selectedIndex = selectedIndex {
            if (selectedIndex < dataArray.count) {
                picker.selectRow(selectedIndex, inComponent: 0, animated: false)
            }
        }
        
        return picker
    }()
    
    private lazy var toolBarView: UIView = {
        
        let barView = UIView()
        barView.backgroundColor = barViewBGColor
        barView.pinConstraints(view, height: barViewHeight, width: view.frame.width)
        
        //add done button
        let doneButton = self.doneButton
        let cancelButton = self.cancelButton
        
        barView.addSubview(doneButton)
        barView.addSubview(cancelButton)
        
        cancelButton.pinConstraints(barView, left: 0, top: 0, bottom: 0, width: buttonWidth)
        doneButton.pinConstraints(barView, right: 0, top: 0, bottom: 0, width: buttonWidth)
        
        if let text = titleText {
            let titleLabel = self.titleLabel
            titleLabel.text = text
            barView.addSubview(titleLabel)
            titleLabel.surroundConstraints(barView, left: buttonWidth, right: -buttonWidth)
        }
        
        doneButton.setTitle(doneText, for: .normal)
        
        if let text = cancelText {
            cancelButton.setTitle(text, for: .normal)
        } else {
            cancelButton.isHidden = true
        }
        
        return barView
    }()
    
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = lineColor
        label.pinConstraints(view, height: lineHeight, width: view.frame.width)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(buttonColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.addTarget(self, action: #selector(onDoneButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(buttonColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.addTarget(self, action: #selector(onCancelButton), for: .touchUpInside)
        return button
    }()
    
    @objc func onDoneButton(sender : UIButton) {
        
        if pickerType == .date {
            onDateSelected?(datePicker.date)
        } else {
            let selectedValueIndex = self.optionPicker.selectedRow(inComponent: 0)
            onOptionSelected?(dataArray[selectedValueIndex], selectedValueIndex)
        }
        
        dismissVC()
    }
    
    @objc func onCancelButton(sender : UIButton) { dismissVC() }
}

//MARK:- UIPickerViewDataSource, UIPickerViewDelegate

extension RPickerController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return dataArray.count }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if (pickerLabel == nil) {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "OpenSans-Semibold", size: 16)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = dataArray[row]
        
        return pickerLabel!
    }
}

// MARK:- Private Extensions

private extension UIApplication {
    static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
//        if #available(iOS 13.0, *) {
//         return UIApplication.shared.connectedScenes
//         .filter({$0.activationState == .foregroundActive})
//         .map({$0 as? UIWindowScene})
//         .compactMap({$0})
//         .first?.windows
//         .filter({$0.isKeyWindow}).first
//         } else {
//         let appDelegate = UIApplication.shared.delegate as? AppDelegate
//         return appDelegate?.window
//         }
    }
}

private extension UIWindow {
    
    static var currentController: UIViewController? {
        return UIApplication.keyWindow?.currentController
    }
    
    var currentController: UIViewController? {
        if let vc = self.rootViewController {
            return topViewController(controller: vc)
        }
        return nil
    }
    
    func topViewController(controller: UIViewController? = UIApplication.keyWindow?.rootViewController) -> UIViewController? {
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
