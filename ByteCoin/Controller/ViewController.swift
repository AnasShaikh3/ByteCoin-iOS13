//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyLabel.text = coinManager.currencyArray[0]
        coinManager.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        
    }    
}


// MARK: - UIPickerView DataSource Delegate

extension ViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}


// MARK: - UIPickerView Delegate

extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyLabel.text = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
    
}


// MARK: - CoinManagerDelegate

extension ViewController : CoinManagerDelegate {
    func didCoinPriceChange(data: CoinData) {
        DispatchQueue.main.async {
            self.rateLabel.text = String(format: "%.0f",data.rate)
        }
    }
    
    func didFailWithError(_ error: any Error) {
        print(error)
    }
}
