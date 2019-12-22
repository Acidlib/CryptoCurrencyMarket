//
//  TradeViewModel.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import UIKit
import Charts

class TradeViewModel: NSObject {
    
    @objc dynamic var model = [Trade]()
    
    override init() {
        super .init()
        NotificationCenter.default.addObserver(self, selector: #selector(valueDidUpdate(_:)), name: .tradeDidUpdate, object: nil)
    }
    
    @objc func valueDidUpdate(_ notification: Notification) {
        if let obj = notification.object as? CCMSubscribedUpdateTrades {
            let trade = Trade(trade: obj)
            print("update: \(NSDate())")
            model.append(trade)
            model = model.sorted(by: { $0.mts.timeIntervalSince1970 < $1.mts.timeIntervalSince1970 })
        }
    }
    
    func getTimestamps() -> [Date] {
        return model.map({ return $0.mts })
    }
    
    // MARK: Charts
    
    func updateLineData(chartView: CombinedChartView) -> LineChartData {
        let entries = model.enumerated().map { (arg) -> ChartDataEntry in
            let (idx, elm) = arg
            return ChartDataEntry(x: Double(idx) + 0.5, y: elm.price)
        }
        
        let leftAxis = chartView.leftAxis
        let min = model.min(by: { $0.price < $1.price})?.price
        let max = model.max(by: { $0.price < $1.price })?.price
        leftAxis.axisMinimum = (min != nil) ? min! - 10 : 100
        leftAxis.axisMaximum = (max != nil) ? max! + 10 : 0
        
        let set = LineChartDataSet(entries: entries, label: "Line DataSet")
        set.setColor(CCMColor.yellowColor())
        set.lineWidth = 2.5
        set.setCircleColor(CCMColor.yellowColor())
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = CCMColor.yellowColor()
        set.valueTextColor = CCMColor.yellowColor()
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.axisDependency = .left
        return LineChartData(dataSet: set)
    }
    
    func updateBarData(chartView: CombinedChartView) -> BarChartData {
        let entries = model.enumerated().map { (arg) -> BarChartDataEntry in
            let (idx, elm) = arg
            return BarChartDataEntry(x: Double(idx) + 0.5, y: elm.amount)
        }
        
        let rightAxis = chartView.rightAxis
        let min = model.min(by: { $0.amount < $1.amount })?.amount
        let max = model.max(by: { $0.amount < $1.amount })?.amount
        rightAxis.axisMinimum = (min != nil) ? min! - 1 : -1
        rightAxis.axisMaximum = (max != nil) ? max! + 1 : 1
        
        let set = BarChartDataSet(entries: entries, label: "Amounts")
        set.setColor(CCMColor.greenColor())
        set.valueTextColor = CCMColor.greenColor()
        set.axisDependency = .right
        
        let groupSpace = 0.01
        let barSpace = 0.02
        let barWidth = 0.48
        let data = BarChartData(dataSets: [set, set])
        data.barWidth = barWidth

        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        return data
    }
}
