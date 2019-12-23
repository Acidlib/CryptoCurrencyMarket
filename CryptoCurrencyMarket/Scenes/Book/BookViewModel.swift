//
//  BookViewModel.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import UIKit

class BookViewModel: NSObject {
    
    var type: CurrencyType = CurrencyType.BTCUSD
    @objc dynamic var model = [Book]()
    
    override init() {
        super .init()
        NotificationCenter.default.addObserver(self, selector: #selector(valueDidUpdate(_:)), name: .bookDidUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(valueWillClear(_:)), name: .clearCurrentSubscription, object: nil)
    }
    
    @objc func valueDidUpdate(_ notification: Notification) {
        if let obj = notification.object as? CCMSubscribedUpdateBooks {
            let book = Book(book: obj)
            model = model.filter({ $0.price != obj.price })
            model.append(book)
            model = model.sorted(by: { $0.price > $1.price })
        }
    }
    
    @objc func valueWillClear(_ notification: Notification) {
        if let userInfo = notification.userInfo, let typeString = userInfo["type"] as? String {
            if CurrencyType(rawValue: typeString) != self.type {
                model.removeAll()
            }
        }
    }
    
    var numberOfItems: Int {
        return model.count
    }
   
    func getBook(at indexPath: IndexPath) -> Book {
        return model[indexPath.row]
    }
}
