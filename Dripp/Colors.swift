//
//  Colors.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var blueHeader:UIColor {
        get {
            return UIColor(hexString: "#2196F3")
        }
    }
    
    class var blue1:UIColor {
        get {
            return UIColor(hexString: "#128ef2")
        }
    }
    
    class var blue2:UIColor {
        get {
            return UIColor(hexString: "#2a99f4")
        }
    }
    
    class var blue3:UIColor {
        get {
            return UIColor(hexString: "#42a5f5")
        }
    }
    
    class var blue4:UIColor {
        get {
            return UIColor(hexString: "#5ab1f6")
        }
    }
    
    class var blue5:UIColor {
        get {
            return UIColor(hexString: "#72bcf8")
        }
    }
    
    class var blue6:UIColor {
        get {
            return UIColor(hexString: "#8bc8f9")
        }
    }
    
    class var feedPurple:UIColor {
        get {
            return UIColor(hexString: "#8493CB")
        }
    }
    
    class var feedGreen:UIColor {
        get {
            return UIColor(hexString: "#7DB171")
        }
    }
    
    class var feedPink:UIColor {
        get {
            return UIColor(hexString: "#D9BAC7")
        }
    }
    
    
    // Creates a UIColor from a Hex string.
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func adjust(red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat) -> UIColor{
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r+red, green: g+green, blue: b+blue, alpha: a+alpha)
    }
    
    // Checks if a color is light or not
    func isLight() -> Bool
    {
        let components = CGColorGetComponents(self.CGColor)
        let brightness = (((components[0] * 299.0) as CGFloat) + ((components[1] * 587.0) as CGFloat) + ((components[2] * 114.0)) as CGFloat) / (1000.0 as CGFloat)
        
        if brightness < 0.5
        {
            return false
        }
        else
        {
            return true
        }
    }
}