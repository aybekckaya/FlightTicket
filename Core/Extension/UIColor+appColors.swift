//
//  UIColor+appColors.swift
//  FlightTicket
//
//  Created by aybek can kaya on 02/10/2017.
//  Copyright © 2017 aybek can kaya. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func navBarColor () -> UIColor {
        return RGBColor(red: 95, green: 157, blue: 45)  // 95,157 ,45
    }
    
    class func RGBColor (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor (red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
    
}
