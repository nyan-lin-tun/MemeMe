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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Disable camera for Simulators
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    
    
    @IBAction func fontsAction(_ sender: UIBarButtonItem) {
    
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

