//
//  DataStore.swift
//  DrinkWater
//
//  Created by Yiğit Karakurt on 16.12.2022.
//

import Foundation

class DataStore{
    
    let defaults = UserDefaults.standard
    
    var currentDay: Int{
        let now = Date()
        let day = Calendar.current.component(.day, from: now)
        
        return day
    }
    
    init(){
        let latestUpdateDay = getLatestUpdateDay()
        
        if latestUpdateDay != currentDay{
            defaults.set(0, forKey: "currentAmount")
        }
    }
    
    func getCurrentAmount() -> Double{
        let savedAmount = defaults.double(forKey: "currentAmount")
        
        return savedAmount
    }
    
    func getLatestUpdateDay() -> Int{
        let latestDay = defaults.integer(forKey: "latestUpdateDay")
        
        return latestDay
    }
    
    func addWater(amount: Double){
        let currentAmount = getCurrentAmount()
        let newAmount = currentAmount + amount
        
        defaults.set(newAmount, forKey: "currentAmount")
        defaults.set(currentDay, forKey: "latestUpdateDay")
    }
    
    
}
