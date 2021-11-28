//
//  MainInfoTableViewCell.swift
//  WeatherMainProject
//
//  Created by Алексей on 27.07.21.
//

import UIKit

protocol MainInfoTableViewCellDelegate: AnyObject {
    func notAddCity()
    func addCity()
}

final class MainInfoTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var currentTempLabel: UILabel!
    @IBOutlet private weak var minMaxTempLabel: UILabel!
    
    
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    
    weak var delegate: MainInfoTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override class func description() -> String {
        return "MainInfoTableViewCell"
    }
    
    func setupMainInfoCell(model: CurrentDayModel, visiableAdditionBtn: Bool) {
        cityLabel.text = model.city
        descriptionLabel.text = model.description
        currentTempLabel.text = "\(model.currentTemp)°"
        minMaxTempLabel.attributedText = getStringTempMaxMin(tempMax: model.maxtemp, tempMin: model.minTemp, type: .long)
        
        cancelButton.isHidden = !visiableAdditionBtn
        addButton.isHidden = !visiableAdditionBtn
        
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        print("cancel")
        self.delegate?.notAddCity()
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        self.delegate?.addCity()
    }
    
}
