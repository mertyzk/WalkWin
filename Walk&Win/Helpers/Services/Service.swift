//
//  Service.swift
//  Walk&Win
//
//  Created by Macbook Air on 9.09.2022.
//

import Foundation

class Service {
    
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=39.8925&lon=32.8164&exclude=daily&appid=8bdbcc30a1306a219f431ab28b68437e")!
    
    func getData(completion: @escaping ([WeatherModel]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print(error?.localizedDescription ?? "error")
            }
            do {
                let result = try JSONDecoder().decode([WeatherModel].self, from: data!)
                completion(result)
                print(result)
            } catch {
                print(error.localizedDescription)
            }
            
            
            
        }.resume()
        
        
    }
    
    
}
