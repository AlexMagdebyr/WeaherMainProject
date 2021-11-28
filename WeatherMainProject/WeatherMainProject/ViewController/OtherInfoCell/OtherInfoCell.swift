//
//  OtherInfoCell.swift
//  WeatherMainProject
//
//  Created by Алексей on 27.07.21.
//

import UIKit

final class OtherInfoCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dataLabel: UILabel!
    
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
    
    func setupOtherInfocell(model: OtherInfoModel) {
        titleLabel.text = model.title
        dataLabel.text = model.data
    }
    
}
