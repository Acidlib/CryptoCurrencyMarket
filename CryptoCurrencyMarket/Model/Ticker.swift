//
//  Ticker.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/21.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import UIKit

class Ticker: NSObject {

    var high: String = "..."
    var low: String = "..."
    var bid: String = "..."
    var ask: String = "..."
    var currentPrice: String = "..."
    var dailyChange: String = "..."
    var dailyChangeRelative: String = "..."
    var volume: String = "..."
    
    init(ticker: CCMSubscribedUpdateTickers?) {
        if let ticker = ticker {
            high = "\(ticker.high)"
            low = "\(ticker.low)"
            bid = "\(ticker.bid)"
            ask = "\(ticker.ask)"
            currentPrice = String(format: "%.2f", ticker.lastPrice)
            dailyChange = String(format: "%@%.2f", ticker.dailyChange > 0 ? "+" : "", ticker.dailyChange)
            dailyChangeRelative = String(format: "%@%.2f %%", ticker.dailyChange > 0 ? "+" : "", ticker.dailyChangeRelative*100)
            volume = String(format: "%.2f", ticker.volume)
        }
    }
}
