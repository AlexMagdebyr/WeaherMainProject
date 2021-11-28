//
//  OneCityTVController.swift
//  WeatherMainProject
//
//  Created by Алексей on 8.08.21.
//

import UIKit

protocol OneCityTVControllerDelegate: AnyObject {
    func addCity(cityData: CityWeather)
}

final class OneCityTVController: UITableViewController {
        
    @IBOutlet private var oneCityTableView: UITableView!
    
    private var dataSource: CityWeather!
    weak var delegate: OneCityTVControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        oneCityTableView.dataSource = self
        oneCityTableView.delegate = self
        
        oneCityTableView.register(cellType: OtherDaysTableViewCell.self)
        oneCityTableView.register(cellType: OtherInfoTableViewCell.self)
        
        oneCityTableView.register(UINib(nibName: MainInfoTableViewCell.description(), bundle: nil), forHeaderFooterViewReuseIdentifier: MainInfoTableViewCell.description())
        
    }
    
    init(model: CityWeather) {
        dataSource = model
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.cityData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource.cityData[indexPath.row] {
       
        case .otherDays(days: let days):
            let cell = oneCityTableView.dequeueReusableCell(with: OtherDaysTableViewCell.self, for: indexPath) //as! OtherDaysTableViewCell
            cell.setupCellOtherDays(model: days)
            return cell
        
        case .otherInfo(info: let info):
            let cell = oneCityTableView.dequeueReusableCell(with: OtherInfoTableViewCell.self, for: indexPath)
            cell.setupCell(model: info)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = oneCityTableView.dequeueReusableHeaderFooterView(withIdentifier: MainInfoTableViewCell.description()) as! MainInfoTableViewCell
        header.delegate = self
        header.setupMainInfoCell(model: dataSource.mainInfo, visiableAdditionBtn: true)
     //   header.contentView
        return header
    }
    
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource.cityData[indexPath.row] {
        case .otherDays:
            return 44
        case .otherInfo:
            return 406//580
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 176
    }
    
    
}


//MARK: - MainInfoTableViewCellDelegate
extension OneCityTVController: MainInfoTableViewCellDelegate {
    func notAddCity() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCity() {
        self.delegate?.addCity(cityData: dataSource)
        self.dismiss(animated: true, completion: nil)
    }
}


