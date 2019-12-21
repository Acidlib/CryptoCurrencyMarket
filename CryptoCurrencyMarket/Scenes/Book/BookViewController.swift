//
//  BookViewController.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/20.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var bookViewModel = BookViewModel()
    private var bookObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    func observeViewModel() {
        self.bookObserver = bookViewModel.observe(\.model, options: [.initial, .new, .old], changeHandler: { (viewModel, change) in
            self.reloadTable()
        })
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension BookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookViewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: bookViewModel.getBook(at: indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
