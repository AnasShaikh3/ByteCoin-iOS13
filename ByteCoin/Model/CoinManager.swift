//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didCoinPriceChange(data: CoinData)
    func didFailWithError(_ error : Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "31035FCC-0D88-4862-988A-2D257070365D"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency:String){
        let fullUrl = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        let url = URL(string: fullUrl)
        performRequest(url)
    }
    
    func performRequest(_ url : URL?){
        let session = URLSession(configuration: .default)
        if let safeUrl = url {
            let task = session.dataTask(with: safeUrl) { data, res, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    parseJSON(safeData)
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data){
        let decoder = JSONDecoder()
        do{
            let result = try decoder.decode(CoinData.self, from: data)
            delegate?.didCoinPriceChange(data:result)
        }catch{
            print(error)
            delegate?.didFailWithError(error)
        }
    }
}
