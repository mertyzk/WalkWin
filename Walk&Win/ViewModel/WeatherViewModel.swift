//
//  WeatherViewModel.swift
//  Walk&Win
//
//  Created by Macbook Air on 9.09.2022.
//

import Foundation

struct WeatherViewModel {
    let weather : WeatherModel
    
    var temp: Double {
        return weather.temp
    }
    
}
