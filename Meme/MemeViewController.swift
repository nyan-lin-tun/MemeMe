//
//  ViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 05/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeImageView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTextFields()

    }
    
    private func setUpTextFields() {
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        self.topTextField.defaultTextAttributes = TextAttributes.attribute
        self.bottomTextField.defaultTextAttributes = TextAttributes.attribute
        self.topTextField.text = "TOP"
        self.bottomTextField.text = "BOTTOM"
        self.topTextField.textAlignment = .center
        self.bottomTextField.textAlignment = .center
        self.topTextField.adjustsFontSizeToFitWidth = true
        self.bottomTextField.adjustsFontSizeToFitWidth = true
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Disable camera for Simulators
        super.viewWillAppear(animated)
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
    }
    
    
    @IBAction func fontsAction(_ sender: UIBarButtonItem) {
        
        let image = UIImage()
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func albumAction(_ sender: UIBarButtonItem) {
        let photoPickerVC = UIImagePickerController()
        photoPickerVC.delegate = self
        photoPickerVC.sourceType = .photoLibrary
        photoPickerVC.allowsEditing = true
        photoPickerVC.modalPresentationStyle = .fullScreen
        self.present(photoPickerVC, animated: true, completion: nil)
    }
    
    @IBAction func cameraAction(_ sender: UIBarButtonItem) {
        let photoPickerVC = UIImagePickerController()
        photoPickerVC.delegate = self
        photoPickerVC.modalPresentationStyle = .fullScreen
        photoPickerVC.sourceType = .camera
        photoPickerVC.allowsEditing = true
        self.present(photoPickerVC, animated: true, completion: nil)
    }
    
}


extension MemeViewController {
    // MARK: Keyboard Notifications
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboradWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboradWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboradWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboradWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
