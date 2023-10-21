//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Maruf's Macbook Pro on 10/10/23.
//

import UIKit
//added uiTextfield delegate to notify viewcontroller whats happening
class WeatherViewController: UIViewController{
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weather = WeatherManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchTextField.delegate = self
        weather.delegate = self
        
    }
    
}

//MARK: - UITextFieldDelegate


extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weather.fetchWeather(cityName: city)
            
        }
        searchTextField.text = ""
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error )
    }
    
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(named: weather.conditionName)
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.cityName
        }
    }
}



