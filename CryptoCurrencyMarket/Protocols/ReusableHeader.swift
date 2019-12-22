//
//  ReusableHeader.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/21.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit

class ReusableHeader: UIView {

    @IBOutlet weak var title: UIView!
    var selection: UIView?
    
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
    }
    
    func setupView() {
        selection = UIView(frame: CGRect(x: 0, y: 80, width: self.frame.width, height: 0))
        selection?.alpha = 0
        selection?.layer.cornerRadius = 8.0
        selection?.backgroundColor = UIColor.yellow
        if let selection = selection { self.addSubview(selection) }
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func willChangeCurrencyPair(_ sender: Any) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [.curveEaseIn], animations: { [weak self] in
            if let _self = self, let selection = _self.selection {
                selection.alpha = 1
                selection.frame = CGRect(x: 0, y: 80, width: _self.frame.width, height: 150)
            }
        }, completion: nil)
    }
    
}
