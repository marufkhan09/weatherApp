//
//  weatherModel.swift
//  WeatherApp
//
//  Created by Maruf's Macbook Pro on 19/10/23.
//

import Foundation


struct WeatherModel {
    let conditionId: Int
    let cityName : String
    let temp : Double
    
    var tempString : String{
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
        switch conditionId {
        case 1000:
            return  "sun.max"
        case 1006:
            return   "cloud.rain"
        case 1135:
            return  "cloud.snow"
        case  1009:
            return  "cloud.fog"
        case 1183:
            return "cloud.drizzle"
        default:
            return  "cloud"
        }
    }
     
}
