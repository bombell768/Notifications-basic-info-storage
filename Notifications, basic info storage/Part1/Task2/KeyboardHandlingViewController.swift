//
//  KeyboardHandlingViewController.swift
//  Notifications, basic info storage
//
//  Created by Bartosz Strzecha on 28/07/2025.
//

import UIKit

class KeyboardHandlingViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Type something here..."
        
        return textField
    }()
    
    private var centerYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupLayout()
        registerForKeyboardNotifications()
    }
    
    private func setupLayout() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        centerYConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYConstraint,
            textField.widthAnchor.constraint(equalToConstant: 240),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillChangeFrame(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else {
            return
        }
        
        let animationCurve = UIView.AnimationOptions(rawValue: curveRaw << 16)
        let keyboardY = endFrame.origin.y
        let screenHeight = UIScreen.main.bounds.height
        
        if keyboardY < screenHeight {
            centerYConstraint.constant = -100
        } else {
            centerYConstraint.constant = 0
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: animationCurve, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

#Preview {
    KeyboardHandlingViewController()
}
