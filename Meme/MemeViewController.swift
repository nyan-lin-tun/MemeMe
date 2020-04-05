//
//  ViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 05/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {

    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var activityButton: UIBarButtonItem!
    @IBOutlet weak var colorButton: UIBarButtonItem!
    
    
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
        if self.memeImageView.image == nil {
            self.activityButton.isEnabled = false
        }else {
            self.activityButton.isEnabled = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
    }
    
    func generateMemedImage() -> UIImage {
        self.topToolBar.isHidden = true
        self.bottomToolBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.topToolBar.isHidden = false
        self.bottomToolBar.isHidden = false
        return memeImage
    }
    
    @IBAction func activityAction(_ sender: UIBarButtonItem) {
        let finalMemeImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [finalMemeImage], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            if activity?.rawValue != "com.apple.UIKit.activity.SaveToCameraRoll" {
                if success {
                    Meme.saveMeme(topTextField: self.topTextField, bottomTextField: self.bottomTextField, originalImage: self.memeImageView.image!, memeImage: finalMemeImage)
                }
            }
        }
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func fontsAction(_ sender: UIBarButtonItem) {
        let fontPickerConfiguration = UIFontPickerViewController().configuration
        fontPickerConfiguration.includeFaces = true
        let fontPickerVC = UIFontPickerViewController(configuration: fontPickerConfiguration)
        fontPickerVC.delegate = self
        self.present(fontPickerVC, animated: true, completion: nil)
    }
    
    @IBAction func colorAction(_ sender: UIBarButtonItem) {
        let colorActionSheet = UIAlertController(title: "Colors", message: nil, preferredStyle: .actionSheet)
        
        colorActionSheet.addAction(UIAlertAction(title: "Red", style: .default, handler: { (_) in
            self.setTextFieldColor(.red)
        }))
        
        colorActionSheet.addAction(UIAlertAction(title: "Green", style: .default, handler: { (_) in
            self.setTextFieldColor(.green)
        }))
        
        colorActionSheet.addAction(UIAlertAction(title: "Blue", style: .default, handler: { (_) in
            self.setTextFieldColor(.blue)
        }))
        
        colorActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(colorActionSheet, animated: true, completion: nil)
    }
    
    private func setTextFieldColor(_ color: UIColor) {
        self.topTextField.textColor = color
        self.bottomTextField.textColor = color
    }
    
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.activityButton.isEnabled = false
        self.memeImageView.image = UIImage(named: "")
        self.setUpTextFields()
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
