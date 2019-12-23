//
//  TickerViewModel.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import UIKit

class TickerViewModel: NSObject {
    
    var type: CurrencyType = CurrencyType.BTCUSD
    @objc dynamic var model = Ticker(ticker: nil)
    
    override init() {
        super .init()
        NotificationCenter.default.addObserver(self, selector: #selector(valueDidUpdate(_:)), name: .tickerDidUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(valueWillClear(_:)), name: .clearCurrentSubscription, object: nil)
    }
    
    func updateModel(obj: CCMSubscribedUpdateTickers) {
        self.model.high = "\(obj.high)"
        self.model.low = "\(obj.low)"
        self.model.bid = "\(obj.bid)"
        self.model.ask = "\(obj.ask)"
        self.model.currentPrice = String(format: "%.2f", obj.lastPrice)
        self.model.dailyChange = String(format: "%@%.2f", obj.dailyChange > 0 ? "+" : "", obj.dailyChange)
        self.model.dailyChangeRelative = String(format: "%@%.2f %%", obj.dailyChange > 0 ? "+" : "", obj.dailyChangeRelative*100)
        self.model.volume = String(format: "%.2f", obj.volume)
    }
    
    @objc func valueDidUpdate(_ notification: Notification) {
        if let obj = notification.object as? CCMSubscribedUpdateTickers {
            self.model = Ticker(ticker: obj)
        }
    }
    
    @objc func valueWillClear(_ notification: Notification) {
        if let userInfo = notification.userInfo, let typeString = userInfo["type"] as? String {
            if let t = CurrencyType(rawValue: typeString), t != self.type {
                self.type = t
                model = Ticker(ticker: nil)
            }
        }
    }
}

