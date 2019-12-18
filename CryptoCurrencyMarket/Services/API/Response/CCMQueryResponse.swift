//
//  CCMQueryResponse.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/17.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import UIKit

public struct CCMAPIResponse {
    var success: Bool
    var errorDescription: String?
    var response: CCMQueryResponse?

    init(success: Bool, errorDescription: String? = nil, response: CCMQueryResponse? = nil) {
        self.success = success
        self.errorDescription = errorDescription
        self.response = response
    }
}

struct CCMQueryResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case test = "test"
    }
    
    let test: Int
    
    init(test: Int) {
        self.test = test
    }

    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.test = try container.decode(Int.self, forKey: .test)
    }
    
    func encode(to encoder: Encoder) throws {
    }
}


struct CCMQueryResponseService {
    var channelId: Int
    var symbol: String
    var channel: String
    var event: String

    init?(json: [String:Any]) {
        if let channelId = json["chanId"] as? Int,
            let symbol = json["symbol"] as? String,
            let channel = json["channel"] as? String,
            let event = json["event"] as? String {
            self.channelId = channelId
            self.symbol = symbol
            self.channel = channel
            self.event = event
        } else {
            return nil
        }
    }
}


struct CCMSubscribedUpdateTickers {
    var bid: Double
    var bidSize: Double
    var ask: Double
    var askSize: Double
    var dailyChange: Double
    var dailyChangeRelative: Double
    var lastPrice: Double
    var volume: Double
    var high: Int
    var low: Int

    init?(array: [NSNumber]) {
        if array.count == 10 {
            self.bid = array[0].doubleValue
            self.bidSize = array[1].doubleValue
            self.ask = array[2].doubleValue
            self.askSize = array[3].doubleValue
            self.dailyChange = array[4].doubleValue
            self.dailyChangeRelative = array[5].doubleValue
            self.lastPrice = array[6].doubleValue
            self.volume = array[7].doubleValue
            self.high = array[8].intValue
            self.low = array[9].intValue
        } else {
            return nil
        }
    }
}


struct CCMSubscribedUpdateTrades {
    var id: Int
    var mts: Double
    var amount: Double
    var price: Double
    
    init?(array: [NSNumber]) {
        if array.count == 4 {
            self.id = array[0].intValue
            self.mts = array[1].doubleValue
            self.amount = array[2].doubleValue
            self.price = array[3].doubleValue
        } else {
            return nil
        }
    }
}


struct CCMSubscribedUpdateBooks {
    let price: Double
    let count: Int
    let amount: Double
    
    init?(array: [NSNumber]) {
        if array.count == 3 {
            self.price = array[0].doubleValue
            self.count = array[1].intValue
            self.amount = array[2].doubleValue
        } else {
            return nil
        }
    }
}
