//
//  CCMConstant.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/19.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation

enum currencyType: String {
    case BTCUSD = "tBTCUSD"
    case ETHUSD = "tETHUSD"
    case tXRPUSD = "tXRPUSD"
}

struct CCMAPIConstant {
    static let tickersQuery = ["event": "subscribe", "channel": "ticker", "symbol": "tBTCUSD"]
    static let booksQuery = ["event": "subscribe", "channel": "book", "symbol": "tBTCUSD"]
    static let tradesQuery = ["event": "subscribe", "channel": "trades", "symbol": "tBTCUSD"]
}
