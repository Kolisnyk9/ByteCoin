//
//  ViewController.swift
//  ByteCoin
//


import UIKit

class ViewController: UIViewController  {

    @IBOutlet weak var currencyPrice: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.delegate = self
    }


}

extension ViewController: CoinManagerDelegate{
    func didUpdatePrice(price: String, currency: String) {
        /*Remember that we need to get hold of the main thread to update the UI, otherwise our app will crash if we try to do this from a background thread (URLSession works in the background).*/
        DispatchQueue.main.async {
            self.currencyPrice.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

