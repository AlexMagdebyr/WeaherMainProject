//
//  CityVerticalCollectionViewCell.swift
//  WeatherMainProject
//
//  Created by Алексей on 6.08.21.
//

import UIKit


final class CityVerticalCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var cityTimeLabel: UILabel!
    @IBOutlet private weak var placeLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCityVerticalCell(cityTime: String, place: String, temperature: Int, timeZone: TimeZone) {
        
        if cityTime == "" {
            let date = NSDate()
            let time = DateFormatter.configureDataStringWihTymeZoneFrom(date: date as Date, dateFormat: DateFormat.timeFull, timeZone: timeZone)
            cityTimeLabel.text = time
        } else {
            cityTimeLabel.text = cityTime
        }
        
        placeLabel.text = place
        temperatureLabel.text = "\(temperature)°"
    }
    
    override class func description() -> String {
        return "CityVerticalCollectionViewCell"
    }
    

}
