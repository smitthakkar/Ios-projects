//
//  WeatherFetcher.swift
//  WeatherForecast
//
//  Created by Kony on 24/06/16.
//  Copyright (c) 2016 Kony. All rights reserved.
//

import Foundation

class WeatherForecast{
    
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather";
    private let openWeatherMapAPIkey = "615a1f05d16ea3f749209b2f3cb551ea"
    
    func getWeather(lat: String, lon: String) -> NSString
    {
        let latti = lat;
        let longi = lon;
        var finaljson: NSString? = nil
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIkey)&lat=\(latti)&lon=\(longi)")!
        
        if let data = NSData(contentsOfURL: weatherRequestURL){
            finaljson = NSString(data: data, encoding: NSUTF8StringEncoding);
        }
        
       
        if finaljson == nil {
            
            finaljson = "NO123"
        }
        
        return finaljson!
    }
    
    
    
}
