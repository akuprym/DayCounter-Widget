//
//  ViewController.swift
//  DayCounter
//
//  Created by admin on 9.02.24.
//
import WidgetKit
import UIKit

class ViewController: UIViewController {
    
    private let datePicker = UIDatePicker()
    
    private let textField: UITextField = {
       let textFeild = UITextField()
        textFeild.placeholder = "Choose a date"
        textFeild.backgroundColor = .white
        return textFeild
    }()
    
    private let textField2: UITextField = {
        let textField2 = UITextField()
        return textField2
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(textField2)
        textField.becomeFirstResponder()
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 50)
        textField.inputView = datePicker
        
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        textField.text = formatDate(date: datePicker.date)
       
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, dd"
        return formatter.string(from: date)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+10, width: view.frame.width-40, height: 50)
        
        button.frame = CGRect(x: 30, y: view.safeAreaInsets.top+70, width: view.frame.width-60, height: 40)
        
        textField2.frame = CGRect(x: 20, y: view.safeAreaInsets.top+130, width: view.frame.width-40, height: 50)
    }

    @objc func didTapButton() {
        textField.resignFirstResponder()
        
        let userDefaults = UserDefaults(suiteName: "group.com.daycounter.widgetcache")
        
        let calendar = Calendar.current
        let date = datePicker.date
        
        let days = calendar.dateComponents([.day], from: date, to: Date())
        
        userDefaults?.setValue(days.day, forKey: "days")
        WidgetCenter.shared.reloadAllTimelines()
    }

}

