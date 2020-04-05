//
//  UIFontPickerExtension.swift
//  Meme
//
//  Created by Nyan Lin Tun on 05/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UIFontPickerViewControllerDelegate {
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        guard let descriptor = viewController.selectedFontDescriptor else { return }
        let selectedFont = UIFont(descriptor: descriptor, size: 30)
        TextAttributes.selectedFont = descriptor.postscriptName
        self.topTextField.font = selectedFont
        self.bottomTextField.font = selectedFont
        
    }
}
