//
//  ReusableHeader.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/21.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit

class ReusableHeader: UIView {

    @IBOutlet weak var title: UILabel!
    var selection: UIView?
    var picker: UIPickerView?
    let pairs = ["BTC/USD", "ETH/USD", "XRP/USD"]
    
    let nibName = "ReusableHeader"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(valueWillClear(_:)), name: .clearCurrentSubscription, object: nil)
    }
    
    func setupView() {
        selection = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0))
        selection?.alpha = 0
        selection?.layer.cornerRadius = 8.0
        selection?.backgroundColor = CCMColor.darkColor()
        if let selection = selection { self.addSubview(selection) }
        
        picker = UIPickerView(frame: selection!.frame)
        picker?.delegate = self
        picker?.dataSource = self
        selection?.addSubview(picker!)
        self.addSubview(selection!)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func willChangeCurrencyPair(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            if let _self = self, let selection = _self.selection {
                selection.alpha = 1
                _self.title.alpha = 0
                selection.frame = CGRect(x: 0, y: 0, width: _self.frame.width, height: 100)
                _self.picker?.frame = selection.bounds
            }
        }) { [weak self] (_) in
            self?.picker?.alpha = 1
        }
    }
    
    @objc func valueWillClear(_ notification: Notification) {
        if let userInfo = notification.userInfo, let typeString = userInfo["type"] as? String {
            title.text = getTitleString(type: CurrencyType(rawValue: typeString)!)
        }
    }
}

extension ReusableHeader: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: pairs[row], attributes: [NSAttributedString.Key.foregroundColor : CCMColor.yellowColor(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .black)])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let type: CurrencyType
        switch row {
        case 0: type = CurrencyType.BTCUSD
        case 1: type = CurrencyType.ETHUSD
        case 2: type = CurrencyType.XRPUSD
        default:type = CurrencyType.BTCUSD
        }
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            if let _self = self, let selection = _self.selection {
                selection.alpha = 0
                _self.picker?.frame = selection.bounds
                _self.title.alpha = 1
            }
        }, completion: { [weak self] (_) in
            if let _self = self, let selection = _self.selection {
                _self.title.text = _self.getTitleString(type: type)
                selection.frame = CGRect(x: 0, y: 0, width: _self.frame.width, height: 0)
            }
        })
        CCMWebSocketClient.shared.reSubscribeTopics(type: type)
    }
    
    func getTitleString(type: CurrencyType) -> String {
        switch type {
        case .BTCUSD:
            return "BTC/USD"
        case .ETHUSD:
            return "ETH/USD"
        case .XRPUSD:
            return "XRP/USD"
        }
    }
    
}
