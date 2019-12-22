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
        
    let months = ["Jan", "Feb", "Mar",
                  "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep",
                  "Oct", "Nov", "Dec"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        
        let rightAxis = chartView.rightAxis
        rightAxis.axisMinimum = 0

        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        xAxis.gridColor = UIColor.white
        xAxis.labelTextColor = UIColor.white
        
        self.updateChartData()
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setChartData()
    }
    
    func setChartData() {
        let data = CombinedChartData()
        data.lineData = generateLineData()
        data.barData = generateBarData()
        chartView.xAxis.axisMaximum = data.xMax + 1
        chartView.data = data
    }
    
    func generateLineData() -> LineChartData {
        let entries = (0..<ITEM_COUNT).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i) + 0.5, y: Double(arc4random_uniform(15) + 5))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Line DataSet")
        set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.lineWidth = 2.5
        set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        
        set.axisDependency = .left
        
        return LineChartData(dataSet: set)
    }
    
    func generateBarData() -> BarChartData {
        let entries1 = (0..<ITEM_COUNT).map { _ -> BarChartDataEntry in
            return BarChartDataEntry(x: 0, y: Double(arc4random_uniform(25) + 25))
        }
        
        let set1 = BarChartDataSet(entries: entries1, label: "Amounts")
        set1.setColor(CCMColor.greenColor())
        set1.valueTextColor = CCMColor.greenColor()
        set1.valueFont = .systemFont(ofSize: 10)
        set1.axisDependency = .left
        
        let groupSpace = 0.01
        let barSpace = 0.02
        let barWidth = 0.48
        let data = BarChartData(dataSets: [set1, set1])
        data.barWidth = barWidth

        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        return data
    }
}

extension TradeViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value) % months.count]
    }
}

