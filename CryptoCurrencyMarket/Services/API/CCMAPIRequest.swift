//
//  CCMAPIRequest.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/17.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit

struct CCMAPIConstant {
    static let tickersPath = ""
    static let booksPath = ""
    static let tradesPath = ""
}

protocol CCMAPIRequest {
    var apiParameters: [String: Any] { get }
}

extension CCMAPIRequest {
    
    var parameters: [String : Any] {
        get {
            var commonParameter = apiParameters
            commonParameter["format"] = "json"
            return commonParameter
        } set {
            
        }
    }
    
}
