//
//  BookCell.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/21.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var count: UIProgressView!
    
    func configure(with book: Book) {
        price.text = "\(book.price)"
        amount.text = String(format: "%.3f", book.amount)
        let cal = Float(book.price * book.amount / 50000)
        count.progress = abs(cal)
        count.progressTintColor = cal > 0 ? CCMColor.greenColor() : CCMColor.redColor()
    }
}

extension BookCell: ReusableView {}
