//
//  CCMQueryRequest.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/17.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit

struct CCMQueryRequest: CCMAPIRequest {
    
    let keyword: String
    var apiParameters: [String : Any] {
        return ["keyword": keyword]
    }
    
}
