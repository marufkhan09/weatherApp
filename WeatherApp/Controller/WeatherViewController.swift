//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Maruf's Macbook Pro on 10/10/23.
//

import UIKit
import CoreLocation
//added uiTextfield delegate to notify viewcontroller whats happening
class WeatherViewController: UIViewController{
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weather = WeatherManager()
    let locationManager = CLLocationManager()
    var lat: CLLocationDegrees = 0.0
    var long: CLLocationDegrees = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchTextField.delegate = self
        weather.delegate = self
        //must set weatherviewcontroller as the delegate before asking for permission
        locationManager.delegate = self
        //request permission request
        locationManager.requestWhenInUseAuthorization()
        //request location
        locationManager.requestLocation()
        
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
//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got location data")
        if let loc = locations.last{
            locationManager.stopUpdatingLocation()
             lat = loc.coordinate.latitude
             long = loc.coordinate.longitude
            weather.fetchWeatherByLatLong(lat: lat, long: long)
        }
        
    }
    
    //have to implement this error function too
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        weather.fetchWeatherByLatLong(lat: lat, long: long)
    }
}



