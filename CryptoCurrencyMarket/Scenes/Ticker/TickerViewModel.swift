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
    private var tickerObserver: NSObjectProtocol?
    @objc dynamic var model = Ticker()
    
    override init() {
        super .init()
    }
    
    func updateModel(obj: CCMSubscribedUpdateTickers) {
        print("vm: \(obj.lastPrice) \(obj.volume)")
        self.model.high = "\(obj.high)"
        self.model.low = "\(obj.low)"
        self.model.bid = "\(obj.bid)"
        self.model.ask = "\(obj.ask)"
        self.model.currentPrice = String(format: "%.2f", obj.lastPrice)
        self.model.dailyChange = String(format: "%@%.2f", obj.dailyChange > 0 ? "+" : "", obj.dailyChange)
        self.model.dailyChangeRelative = String(format: "%@%.2f %%", obj.dailyChange > 0 ? "+" : "", obj.dailyChangeRelative*100)
        self.model.volume = String(format: "%.2f", obj.volume)
    }
}

