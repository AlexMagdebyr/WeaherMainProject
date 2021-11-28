//
//  LastVerticalCVCell.swift
//  WeatherMainProject
//
//  Created by Алексей on 7.08.21.
//

import UIKit

protocol LastVerticalCVCellDelegate: AnyObject {
    func addCity(city: String)
}

final class LastVerticalCVCell: UICollectionViewCell {

    weak var delegate: LastVerticalCVCellDelegate?
    private var numberPressed = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override class func description() -> String {
        return "LastVerticalCVCell"
    }
    
   
    @IBAction private func addCityBtn(_ sender: UIButton) {
        numberPressed = numberPressed + 1
        let newCity = chooseCity(index: numberPressed)
        delegate?.addCity(city: newCity)
    }
    
    private func chooseCity(index: Int) -> String {
        var city: String
        if index == 1 {
            city =  "Moskva"
        } else if index == 2 {
            city =  "Kiev"
        } else if index == 3 {
            city =  "Vena"
        } else if index == 4 {
            city =  "Barcelona"
        } else if index == 5 {
            city =  "Kair"
        } else if index == 6 {
            city =  "Tokio"
        } else if index == 7 {
            city =  "Dubai"
        } else if index == 8 {
            city =  "Paris"
        } else  {
            city =  "Amsterdam"
        }
        return city
    }
}
