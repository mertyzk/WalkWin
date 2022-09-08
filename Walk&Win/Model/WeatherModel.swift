//
//  WeatherModel.swift
//  Walk&Win
//
//  Created by Macbook Air on 8.09.2022.
//

import Foundation

/*struct WeatherModel {
    
    static let shared = WeatherModel()
    let BASEURL = "https://api.openweathermap.org/data/3.0/"
    let ONECALL = "onecall?"
    let APIKEY = "83720177a638d0171ec52435e64956c3"
    var latitude = 0.0
    var longitude = 0.0
    let EXCLUDE = "current"

    

    public func getCurrentWeather(){
        let url = "\(BASEURL)\(ONECALL)lat=\(latitude)&lon=\(longitude)&exclude=\(EXCLUDE)&appid=\(APIKEY)"
        print(url)
        
/*
 https://api.openweathermap.org/data/2.5/weather?lat=39.8925&lon=32.8164&exclude=daily&appid=8bdbcc30a1306a219f431ab28b68437e
 */
    }
    
    
    
    
    

}*/


import Foundation

struct WeatherModel: Codable {
    let temp: Double
}
