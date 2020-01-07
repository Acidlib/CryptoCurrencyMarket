//
//  Book.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/21.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation

class Book: NSObject {

    var price: Double = 0
    var amount: Double = 0
    var count: Int = 0
    
    init(_ book: CCMSubscribedUpdateBooks) {
        price = book.price
        amount = book.amount
        count = book.count
    }
}

