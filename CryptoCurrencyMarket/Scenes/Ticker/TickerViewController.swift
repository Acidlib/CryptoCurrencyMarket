//
//  TickerViewController.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit

class TickerViewController: UIViewController {
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var bid: UILabel!
    @IBOutlet weak var ask: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var dailyChange: UILabel!
    @IBOutlet weak var dailyChangeRelative: UILabel!
    @IBOutlet weak var volume: UILabel!
    
    var tickerViewModel = TickerViewModel()
    private var tickerObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        updateUIElements()
    }
    
    func observeViewModel() {
        self.tickerObserver = tickerViewModel.observe(\.model, options: [.initial, .new, .old], changeHandler: { (viewModel, change) in
            self.updateUIElements()
        })
    }
    
    func updateUIElements() {
        DispatchQueue.main.async {
            self.high.text = self.tickerViewModel.model.high
            self.low.text = self.tickerViewModel.model.low
            self.bid.text = self.tickerViewModel.model.bid
            self.ask.text = self.tickerViewModel.model.ask
            self.currentPrice.text = self.tickerViewModel.model.currentPrice
            self.dailyChange.text = self.tickerViewModel.model.dailyChange
            self.dailyChangeRelative.text = self.tickerViewModel.model.dailyChangeRelative
            self.volume.text = self.tickerViewModel.model.volume
            if self.dailyChange.text!.range(of:"+") != nil {
                self.dailyChangeRelative.textColor = CCMColor.greenColor()
                self.dailyChange.textColor = CCMColor.greenColor()
            } else {
                self.dailyChangeRelative.textColor = CCMColor.redColor()
                self.dailyChange.textColor = CCMColor.redColor()
            }
        }
    }
}
