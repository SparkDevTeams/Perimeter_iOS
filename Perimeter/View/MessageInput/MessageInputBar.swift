//
//  MessageInputBar.swift
//  Perimeter
//
//  Created by Davone Barrett on 10/25/18.
//  Copyright © 2018 SparkDev. All rights reserved.
//

import Foundation
import UIKit

class MessageInputBar: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    weak var delegate: MessageInputDelegate?
    
    var cameraButton: UIButton!
    var sendButton: UIButton!
    var messageTextField: UITextField!
    
    var bottomConstraint: NSLayoutConstraint!
    
    var inputContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    convenience init() {
        self.init(frame: .zero)
        print("Initializing with frame")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        registerObservers()
    }
    
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = UIColor.white
        
        setupConstraints()
        
        print("Did move to super view")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use default init")
    }
    
    private func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNoti(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNoti(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    public func resign() {
        messageTextField.resignFirstResponder()
    }
    
    @objc private func sendMessage() {
        let text = messageTextField.text
        messageTextField.text = ""
        messageTextField.resignFirstResponder()
        delegate?.userDidPressSendButton(message: text)
    }
    
    @objc private func handleKeyboardNoti(notification: Notification) {
        
        if notification.name == NSNotification.Name.UIKeyboardWillShow {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                bottomConstraint.constant -= keyboardSize.height
                print("Keyboard is about to show with a frame of \(keyboardSize)")
            }
        } else if notification.name == NSNotification.Name.UIKeyboardWillHide {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                bottomConstraint.constant = 0
                print("Keyboard is about to hide with frame of \(keyboardSize)")
            }
        }
        
    }
    
    private func setupInput() {
        // set up send button
        sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        // send button constraint
        inputContentView.addSubview(sendButton)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.centerYAnchor.constraint(equalTo: inputContentView.centerYAnchor, constant: 0).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: inputContentView.trailingAnchor, constant: 0).isActive = true
        //sendButton.widthAnchor.constraint(equalToConstant: 30)
        
        // setup camera button
        cameraButton = UIButton(type: .system)
        cameraButton.setTitle("Camera", for: .normal)
        
        inputContentView.addSubview(cameraButton)
        
        // set up constraints
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.leadingAnchor.constraint(equalTo: inputContentView.leadingAnchor, constant: 5).isActive = true
        cameraButton.centerYAnchor.constraint(equalTo: inputContentView.centerYAnchor, constant: 0).isActive = true
        cameraButton.setContentHuggingPriority(.required, for: .horizontal)
        
        
        messageTextField = UITextField()
        messageTextField.borderStyle = .roundedRect
        
        inputContentView.addSubview(messageTextField)
        
        // set up constraints
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 5).isActive = true
        messageTextField.leadingAnchor.constraint(equalTo: cameraButton.trailingAnchor, constant: 5).isActive = true
        messageTextField.centerYAnchor.constraint(equalTo: inputContentView.centerYAnchor, constant: 0).isActive = true
        messageTextField.centerXAnchor.constraint(equalTo: inputContentView.centerXAnchor, constant: 0).isActive = true
        
    }
    
    private func setupContentViewConstraints() {
        addSubview(inputContentView)
        
        inputContentView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = inputContentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        let leadingConsraint = inputContentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        let trailingConstriant = inputContentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        let heightConstraint = inputContentView.heightAnchor.constraint(equalToConstant: 50)
        let widthConstraint = inputContentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConsraint, trailingConstriant, heightConstraint, widthConstraint])
        
        setupInput()
    }
    
    private func setupConstraints() {
        guard let window = window else {return}
        
        translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstraint = bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor)
        let leadingConsraint = leadingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstriant = trailingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.trailingAnchor)
        let heightConstraint = heightAnchor.constraint(equalToConstant: 50)
        let widthConstraint = widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConsraint, trailingConstriant, heightConstraint, widthConstraint])
        
        setupContentViewConstraints()
    }
    
}
