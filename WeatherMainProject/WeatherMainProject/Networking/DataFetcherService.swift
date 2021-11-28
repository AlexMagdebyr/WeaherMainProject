//
//  DataFetcherService.swift
//  WeatherMainProject
//
//  Created by Алексей on 27.07.2021.
//

import Foundation

class DataFetcherService {
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }

    
    func getWeather(cityName: String, completion: @escaping (WeatherResponse?) -> Void) {
        let urlForCodes = "https://api.openweathermap.org/data/2.5/weather"
        let params: [String : String] = ["q"     : cityName,
                                         "appid" : "64b33b91272f06dc53f406df2349ea19",
                                         "lang"  : "ru",
                                         "units" : "metric"]
        
        networkDataFetcher.getGenericJSONDataWith(type: .GET, urlString: urlForCodes, parameters: params, response: completion)
        
    }
    
    
    func getWeatherDays(cnt: String, cityName: String, completion: @escaping (WeatherDaysResponse?) -> Void) {
        let urlForCodes = "https://api.openweathermap.org/data/2.5/forecast/daily"
        let params: [String : String] = ["q"     : cityName,
                                         "appid" : "64b33b91272f06dc53f406df2349ea19",
                                         "lang"  : "ru",
                                         "units" : "metric",
                                         "cnt" : cnt]
        
        networkDataFetcher.getGenericJSONDataWith(type: .GET, urlString: urlForCodes, parameters: params, response: completion)
        
    }
    
}
