//
//  Trade.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/21.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation

class Trade: NSObject {

    var price: Double = 0
    var mts: Date
    var amount: Double = 0
        
    init(trade: CCMSubscribedUpdateTrades) {
        price = trade.price
        mts = Date(timeIntervalSince1970: TimeInterval(trade.mts/1000))
        amount = trade.amount
    }
    
    // mock init
    init(price: Double, mts: Date, amount:Double) {
        self.price = price
        self.mts = mts
        self.amount = amount
    }
}
