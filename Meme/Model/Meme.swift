//
//  Meme.swift
//  Meme
//
//  Created by Nyan Lin Tun on 05/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memeImage: UIImage
       
    static func saveMeme(topTextField: UITextField,
                         bottomTextField: UITextField,
                         originalImage: UIImage,
                         memeImage: UIImage) {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: originalImage, memeImage: memeImage)
        UIImageWriteToSavedPhotosAlbum(meme.memeImage, self, nil, nil)
        
    }
}
