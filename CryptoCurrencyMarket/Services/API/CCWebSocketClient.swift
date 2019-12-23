//
//  CCMWebSocketClient.swift
//  CryptoCurrencyMarket
//
//  Created by Yi-Ling Wu on 2019/12/17.
//  Copyright © 2019 Yi-Ling Wu. All rights reserved.
//

import Foundation
import Starscream

class CCMWebSocketClient: CCMAPIRequest {

    static let shared = CCMWebSocketClient()
    private var channelList: [Int: String] = [:]
    private let socket: WebSocket = WebSocket(url: URL(string: "wss://api-pub.bitfinex.com/ws/2")!)
    
    init() {
        defer {
        }
    }
    
    func requestAPICall(_ input: CCMAPIRequest, _ completion: @escaping (CCMAPIResponse) -> Void) {
    }
}

extension CCMWebSocketClient: WebSocketDelegate {

    func conectToServer() {
        socket.delegate = self
        socket.connect()
    }
    
    private func subscribeTicker() {
        
    }
    
    private func subscribeToTopics(_ dic: Dictionary<String, String>) {
        do {
            let jsonObj = try JSONSerialization.data(withJSONObject: dic, options: [])
            socket.write(data: jsonObj)
        } catch let error {
            print("serialize json: \(error)")
        }
    }
    
    private func handleServiceResponse(_ dic: Dictionary<String, Any>) {
        if let subscribed = CCMQueryResponseService(json: dic) {
            channelList[subscribed.channelId] = subscribed.channel
        }
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        subscribeToTopics(CCMAPIConstant().tickersQuery)
        subscribeToTopics(CCMAPIConstant().booksQuery)
        subscribeToTopics(CCMAPIConstant().tradesQuery)
    }
    
    func reSubscribeTopics(type: CurrencyType) {
        NotificationCenter.default.post(name: NSNotification.Name.clearCurrentSubscription, object: self, userInfo: ["type": type.rawValue])
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected: \(error?.localizedDescription ?? "unknown reason")")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        let data = text.data(using: .utf8)!
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any> {
                handleServiceResponse(json)
            } else if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Array<Any> {
                if let chanId = jsonArray[0] as? Int,
                    let chanelName = channelList[chanId],
                    jsonArray.count > 1 {
                    switch chanelName {
                    case "ticker":
                        if let bodyArray = jsonArray[1] as? Array<NSNumber>, let ticker = CCMSubscribedUpdateTickers(array: bodyArray) {
                            NotificationCenter.default.post(name: .tickerDidUpdate, object: ticker)
                        }
                    case "trades":
                        if jsonArray.count > 2, let bodyArray = jsonArray[2] as? Array<NSNumber>, let trades = CCMSubscribedUpdateTrades(array: bodyArray) {
                            NotificationCenter.default.post(name: .tradeDidUpdate, object: trades)
                        }
                    case "book":
                        if let bodyArray = jsonArray[1] as? Array<NSNumber>, let book = CCMSubscribedUpdateBooks(array: bodyArray) {
                            NotificationCenter.default.post(name: .bookDidUpdate, object: book)
                        }
                    default:
                        print("")
                    }
                }
            } else {
                print("Unparsed MSG: \(text)")
            }
        } catch let error as NSError {
            print("MSG: error to json: \(error) rawString:\(text)")
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Data: \(data.count)")
    }
}
