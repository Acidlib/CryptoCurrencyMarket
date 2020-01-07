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
    var dailyChange: NSAttributedString = NSAttributedString(string:"...")
    var dailyChangeRelative: NSAttributedString = NSAttributedString(string:"...")
    var volume: String = "..."
    
    init(_ ticker: CCMSubscribedUpdateTickers?) {
        if let ticker = ticker {
            high = String(format: "%.2f", ticker.high)
            low = String(format: "%.2f", ticker.low)
            bid = String(format: "%.2f", ticker.bid)
            ask = String(format: "%.2f", ticker.ask)
            currentPrice = String(format: "%.2f", ticker.lastPrice)
            volume = String(format: "%.2f", ticker.volume)
            dailyChange = NSAttributedString(string: String(format: "%@%.2f", ticker.dailyChange > 0 ? "+" : "", ticker.dailyChange), attributes: [NSAttributedString.Key.foregroundColor: ticker.dailyChange > 0 ? CCMColor.greenColor() : CCMColor.redColor()])
            dailyChangeRelative = NSAttributedString(string: String(format: "%@%.2f", ticker.dailyChangeRelative > 0 ? "+" : "", ticker.dailyChangeRelative), attributes: [NSAttributedString.Key.foregroundColor: ticker.dailyChangeRelative > 0 ? CCMColor.greenColor() : CCMColor.redColor()])
        }
    }
}
