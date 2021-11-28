//
//  String.swift
//  WeatherMainProject
//
//  Created by Алексей on 02.08.2021.
//

import Foundation
import UIKit

enum TypeTemperatureString {
    case long
    case short
}

func getStringTempMaxMin(tempMax: Int, tempMin: Int, type: TypeTemperatureString) -> NSAttributedString {
    
    switch type {
    case .long:
        let attributedString = NSAttributedString(string: "Макс. \(tempMax)°, мин. \(tempMin)°", attributes: [.font : UIFont.systemFont(ofSize:  17.0)])
        
        return attributedString
    case .short:
        
        let attributedString = NSMutableAttributedString(string: "\(tempMax)", attributes: [.font : UIFont.systemFont(ofSize:  17.0)])
        
        attributedString.append(NSAttributedString(string: "   \(tempMin)", attributes: [.font : UIFont.systemFont(ofSize:  17.0), .foregroundColor : UIColor.systemGray4]))
        
        
        return attributedString
    }
   
}
