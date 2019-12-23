//
//  CCMColor.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/21.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import UIKit

struct CCMColor {
    static func greenColor() -> UIColor {
        return UIColor().hexColor(hex: "6effbe")
    }
    
    static func redColor() -> UIColor {
        return UIColor().hexColor(hex: "ff7542")
    }
    
    static func yellowColor() -> UIColor {
        return UIColor().hexColor(hex: "fae846")
    }
    
    static func darkColor() -> UIColor {
        return UIColor().hexColor(hex: "1d212f")
    }
}
