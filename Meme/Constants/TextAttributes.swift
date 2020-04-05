//
//  TextAttributes.swift
//  Meme
//
//  Created by Nyan Lin Tun on 05/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation
import UIKit

struct TextAttributes {
    
    static var selectedFont:String = "Impact"
    
    static var fonts : [String] {
        var fontsArray = [String]()
        for family in UIFont.familyNames {
            for font in UIFont.fontNames(forFamilyName: family) {
                //Check Impact font include or not
                font != "Impact" ? fontsArray.append(font) : ()
            }
        }
        fontsArray.sort()
        fontsArray.insert("Impact", at: 0)
        return fontsArray
    }
    
    static var attribute: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: TextAttributes.selectedFont, size: 30)!,
        NSAttributedString.Key.strokeWidth:  -1
    ]
}
