//
//  BookViewModel.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import UIKit

class BookViewModel {
    
    let model = CCMSubscribedUpdateBooks(array: [])
    
    init() {
    }
    
    @objc func valueDidUpdate(_ notification: Notification) {
    }
}
