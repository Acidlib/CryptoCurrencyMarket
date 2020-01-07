//
//  TickerViewController.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    func observeViewModel() {
        self.tickerViewModel.high.bind(to: self.high.rx.text).disposed(by: disposeBag)
        self.tickerViewModel.low.bind(to: self.low.rx.text).disposed(by: disposeBag)
        self.tickerViewModel.bid.bind(to: self.bid.rx.text).disposed(by: disposeBag)
        self.tickerViewModel.ask.bind(to: self.ask.rx.text).disposed(by: disposeBag)
        self.tickerViewModel.currentPrice.bind(to: self.currentPrice.rx.text).disposed(by: disposeBag)
        self.tickerViewModel.volume.bind(to: self.volume.rx.text).disposed(by: disposeBag)
        self.tickerViewModel.dailyChange.bind(to: self.dailyChange.rx.attributedText).disposed(by: disposeBag)
        self.tickerViewModel.dailyChangeRelative.bind(to: self.dailyChangeRelative.rx.attributedText).disposed(by: disposeBag)
    }
}
