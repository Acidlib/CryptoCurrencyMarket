//
//  CCMConstant.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/19.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation

enum CurrencyType: String {
    case BTCUSD = "tBTCUSD"
    case ETHUSD = "tETHUSD"
    case XRPUSD = "tXRPUSD"
}

struct CCMAPIConstant {
    var tickersQuery: [String: String]
    var booksQuery: [String: String]
    var tradesQuery: [String: String]
    
    init(type: CurrencyType=CurrencyType.BTCUSD) {
        tickersQuery = ["event": "subscribe", "channel": "ticker", "symbol": type.rawValue]
        booksQuery = ["event": "subscribe", "channel": "book", "symbol": type.rawValue]
        tradesQuery = ["event": "subscribe", "channel": "trades", "symbol": type.rawValue]
    }
}

extension Notification.Name {
    static var tickerDidUpdate: Notification.Name { return .init(rawValue: "CCMConstant.tickerDidUpdate") }
    static var tradeDidUpdate: Notification.Name { return .init(rawValue: "CCMConstant.tradeDidUpdate") }
    static var bookDidUpdate: Notification.Name { return .init(rawValue: "CCMConstant.bookDidUpdate") }
    
    static var clearCurrentSubscription: Notification.Name { return .init(rawValue: "CCMConstant.clearCurrentSubscription") }
}

