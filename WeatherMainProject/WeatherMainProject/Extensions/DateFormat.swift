//
//  File.swift
//  WeatherMainProject
//
//  Created by Алексей on 02.08.2021.
//

import Foundation

enum DateFormat: String {
    case dayTitle = "EEEE"
    case timeFull = "HH:mm"
    case dateTitle = "E, dd MMMM"
}

// MARK: - DateFormatter
extension DateFormatter {
    
    static func configureDataStringFrom(epoch: Int, dateFormat: DateFormat) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(epoch)) as Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: date)
    }
    
    static func configureDataStringWihTymeZoneFrom(date: Date, dateFormat: DateFormat, timeZone: TimeZone) -> String {
   //     let date = NSDate(timeIntervalSince1970: TimeInterval(epoch)) as Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = .current
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: date)
//        
    }
    
    static func timeDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        //dateFormatter.dateFormat = "'T'HH:mm:ssZ"
        //dateFormatter.dateFormat = "'T'HH:mm:ss"
        //dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter
    }
    
    static func dateDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }
    
    static func dayTimeDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.timeZone = .current
        //dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.locale = .current
        //dateFormatter.dateFormat = "dd'T'HH:mm:ssZ"
        //dateFormatter.dateFormat = "dd'T'HH:mm:ss"
        dateFormatter.dateFormat = "dd HH:mm:ss"
        
   //     dateFormatter.date(from: <#T##String#>)
        
        return dateFormatter
    }
    
    static func longDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.timeZone = .current
        //dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
     //   dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss at h:mm a"
        
        return dateFormatter
    }
    
    static func newDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
//        dateFormatter.locale = .current
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .medium
        
        dateFormatter.dateFormat = "E, dd MMMM"
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
     //   dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss at h:mm a"
        
        return dateFormatter
    }
    
   
}

