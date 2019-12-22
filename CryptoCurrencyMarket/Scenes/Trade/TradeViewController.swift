//
//  TradeViewController.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit
import Charts

private let ITEM_COUNT = 12

class TradeViewController: ChartBaseViewController {

    @IBOutlet var chartView: CombinedChartView!
    var tradeViewModel = TradeViewModel()
    private var tradeObserver: NSObjectProtocol?
    let data = CombinedChartData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharts()
        observeViewModel()
    }
    
    func setupCharts() {
        chartView.delegate = self
        let xAxis = chartView.xAxis
        xAxis.axisMinimum = 0
        xAxis.gridColor = UIColor.white
        xAxis.labelTextColor = UIColor.white
        xAxis.labelPosition = .bothSided
        xAxis.valueFormatter = self
        chartView.pinchZoomEnabled = true
        chartView.dragEnabled = true
        chartView.doubleTapToZoomEnabled = true
        chartView.dragXEnabled = true
        chartView.leftAxis.labelTextColor = CCMColor.yellowColor()
        chartView.rightAxis.labelTextColor = CCMColor.greenColor()
    }
    
    func observeViewModel() {
        self.tradeObserver = tradeViewModel.observe(\.model, options: [.initial, .new, .old], changeHandler: { [weak self] (viewModel, change) in
            self?.updateChartData()
        })
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setChartData()
    }
    
    func setChartData() {
        data.lineData = tradeViewModel.updateLineData(chartView: chartView)
        data.barData = tradeViewModel.updateBarData(chartView: chartView)
        chartView.xAxis.axisMaximum = data.xMax + 1
        chartView.data = data
    }
}

extension TradeViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let axisArr = self.tradeViewModel.getTimestamps()
        return axisArr.count == 0 ? "" : axisArr[Int(value) % axisArr.count].timeInHourMinString()
    }
}

