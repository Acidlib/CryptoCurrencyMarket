//
//  CCMWebSocketClient.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/17.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import Starscream

class CCMWebSocketClient: CCMAPIRequest {
    
    var apiParameters: [String : Any] = [:]
    
    static let shared = CCMWebSocketClient()
    
    init() {
        defer {
        }
    }
    
    func requestAPICall(_ input: CCMAPIRequest, _ completion: @escaping (CCMAPIResponse) -> Void) {
    }
}

