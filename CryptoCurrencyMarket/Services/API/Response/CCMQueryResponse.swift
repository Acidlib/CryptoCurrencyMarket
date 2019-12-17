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
