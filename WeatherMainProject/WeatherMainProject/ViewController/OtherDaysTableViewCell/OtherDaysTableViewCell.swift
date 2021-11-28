//
//  OtherDaysTableViewCell.swift
//  WeatherMainProject
//
//  Created by Алексей on 27.07.21.
//

import UIKit
import SDWebImage

final class OtherDaysTableViewCell: UITableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setupCellOtherDays(model: OtherDayModel) {
      
        dateLabel.text = model.date
        
        temperatureLabel.attributedText = getStringTempMaxMin(tempMax: model.maxtemp, tempMin: model.minTemp, type: .short)

        iconImageView.sd_setImage(with: URL(string: model.icon),
                                 placeholderImage: nil,
                                 options: .refreshCached, context: nil)
    }
    
}
