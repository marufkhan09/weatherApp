//
//  weatherManager.swift
//  WeatherApp
//
//  Created by Maruf's Macbook Pro on 18/10/23.
//

import Foundation


struct WeatherManager {
    let weatherUrl = "https://api.weatherapi.com/v1/current.json?key=a9b8fcf50a2948789a1101258231810&q="
    var delegate : WeatherManagerDelegate?
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //1. create a url
        if let url = URL(string: urlString){
            //2.create a urlsession
            let session = URLSession(configuration: .default)
            //3. give session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if(error != nil){
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if  let weather = parseJson(weatherData: safeData) {
                        delegate?.didUpdateWeather(weather)
                    }
                }
                
            }
            task.resume()
            
        }
        
    }
    
    func  parseJson (weatherData: Data)-> WeatherModel?{
        let decoder = JSONDecoder()
        
        do {
            let decodedData =  try  decoder.decode(WeatherDataModel.self, from: weatherData)
            let id = decodedData.current!.condition!.code!
            let temp = decodedData.current!.temp_c!
            let name = decodedData.location!.name!
            let weather = WeatherModel(conditionId: id, cityName: name, temp: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
    
    
}
