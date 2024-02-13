//
//  ViewController.swift
//  DayCounter
//
//  Created by admin on 9.02.24.
//
import WidgetKit
import UIKit

class ViewController: UIViewController {

    private let textField: UITextField = {
       let textFeild = UITextField()
        textFeild.placeholder = "Choose a date"
        textFeild.backgroundColor = .white
        return textFeild
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
        textField.becomeFirstResponder()
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let datePicker = UIDatePicker()
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
    }

    @objc func didTapButton() {
        textField.resignFirstResponder()
        
        let userDefaults = UserDefaults(suiteName: "group.com.daycounter.widgetcache")
        
        guard let text = textField.text, !text.isEmpty else { return }
        
        userDefaults?.setValue(text, forKey: "text")
        WidgetCenter.shared.reloadAllTimelines()
    }

}

