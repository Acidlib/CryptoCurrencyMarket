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
    
    @objc dynamic var model = [Book]()
    
    override init() {
        super .init()
        NotificationCenter.default.addObserver(self, selector: #selector(valueDidUpdate(_:)), name: .bookDidUpdate, object: nil)
    }
    
    @objc func valueDidUpdate(_ notification: Notification) {
        if let obj = notification.object as? CCMSubscribedUpdateBooks {
            let book = Book(book: obj)
            model = model.filter({ $0.price != obj.price })
            model.append(book)
            model = model.sorted(by: { $0.price > $1.price })
        }
    }
    
    var numberOfItems: Int {
        return model.count
    }
   
    func getBook(at indexPath: IndexPath) -> Book {
        return model[indexPath.row]
    }
}
