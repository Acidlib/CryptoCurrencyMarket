//
//  TickerViewModel.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TickerViewModel: NSObject {
    
    var type: CurrencyType = CurrencyType.BTCUSD
    let disposeBag = DisposeBag()
    var model = Ticker(nil)
    
    override init() {
        super .init()
        CCMWebSocketClient.shared.subTicker.subscribe({ [weak self] event in
            if let ticker = event.element {
                self?.model = ticker
            }
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(self, selector: #selector(valueWillClear(_:)), name: .clearCurrentSubscription, object: nil)
    }
    
    @objc func valueWillClear(_ notification: Notification) {
        if let userInfo = notification.userInfo, let typeString = userInfo["type"] as? String {
            if let t = CurrencyType(rawValue: typeString), t != self.type {
                self.type = t
                model = Ticker(nil)
            }
        }
    }
}

extension TickerViewModel {
    var high: Observable<String> {
        return Observable<String>.just(model.high)
    }
    
    var low: Observable<String> {
        return Observable<String>.just(model.low)
    }
    
    var bid: Observable<String> {
        return Observable<String>.just(model.bid)
    }
    
    var ask: Observable<String> {
        return Observable<String>.just(model.ask)
    }
    
    var currentPrice: Observable<String> {
        return Observable<String>.just(model.currentPrice)
    }
    
    var dailyChange: Observable<NSAttributedString> {
        return Observable<NSAttributedString>.just(model.dailyChange)
    }
    
    var dailyChangeRelative: Observable<NSAttributedString> {
        return Observable<NSAttributedString>.just(model.dailyChangeRelative)
    }

    var volume: Observable<String> {
        return Observable<String>.just(model.volume)
    }
}
