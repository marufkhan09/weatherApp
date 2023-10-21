//
//  doubleToNumOfPlaces.swift
//  WeatherApp
//
//  Created by Maruf's Macbook Pro on 21/10/23.
//

import Foundation


extension Double {
    func round(to places: Int)-> Double{
        let precisionNum = pow(10, Double(places))
      var  n = self
        n = n * precisionNum
        n.round()
        n = n / precisionNum
        return n
    }
}
