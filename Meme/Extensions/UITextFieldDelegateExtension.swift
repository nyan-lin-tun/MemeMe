//
//  UITextFieldDelegateExtension.swift
//  Meme
//
//  Created by Nyan Lin Tun on 05/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.topTextField {
            self.topTextField.text = ""
        }else {
            self.bottomTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.topTextField {
            self.topTextField.resignFirstResponder()
        }else {
            self.bottomTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.topTextField {
            if self.topTextField.text!.isEmpty {
                self.topTextField.text = "TOP"
            }
        }else {
            if self.bottomTextField.text!.isEmpty {
                self.bottomTextField.text = "BOTTOM"
            }
        }
    }
    
}
