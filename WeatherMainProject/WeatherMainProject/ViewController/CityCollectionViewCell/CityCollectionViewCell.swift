//
//  CityCollectionViewCell.swift
//  WeatherMainProject
//
//  Created by Алексей on 31.07.21.
//

import UIKit

final class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var weatherDataTableView: UITableView!
    private var dataSource: CityWeather!
    
    var parallaxOffsetSpeed: CGFloat = 30
    var cellHeight: CGFloat = 184
    
    var parallaxViewHight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4*parallaxOffsetSpeed*self.frame.height) - cellHeight)/2
        return maxOffset + self.cellHeight
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherDataTableView.dataSource = self
        weatherDataTableView.delegate = self
        
        
        weatherDataTableView.register(cellType: OtherDaysTableViewCell.self)
        weatherDataTableView.register(cellType: OtherInfoTableViewCell.self)
        
        weatherDataTableView.register(UINib(nibName: MainInfoTableViewCell.description(), bundle: nil), forHeaderFooterViewReuseIdentifier: MainInfoTableViewCell.description())
        
    
    }
    
    override class func description() -> String {
        return "CityCollectionViewCell"
    }
    
    func setupCityCVCell(model: CityWeather) {
        dataSource = model
        weatherDataTableView.reloadData()
    }
    
    func parallaxOffset(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        return (newOffsetY - cell.frame.origin.y)/parallaxViewHight*parallaxOffsetSpeed
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension CityCollectionViewCell: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.cityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource.cityData[indexPath.row] {
       
        case .otherDays(days: let days):
            let cell = weatherDataTableView.dequeueReusableCell(with: OtherDaysTableViewCell.self, for: indexPath) //as! OtherDaysTableViewCell
            cell.setupCellOtherDays(model: days)
            return cell
        
        case .otherInfo(info: let info):
            let cell = weatherDataTableView.dequeueReusableCell(with: OtherInfoTableViewCell.self, for: indexPath)
            cell.setupCell(model: info)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = weatherDataTableView.dequeueReusableHeaderFooterView(withIdentifier: MainInfoTableViewCell.description()) as! MainInfoTableViewCell
        header.setupMainInfoCell(model: dataSource.mainInfo, visiableAdditionBtn: false)
        return header
    }
    
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource.cityData[indexPath.row] {
        case .otherDays:
            return 44
        case .otherInfo:
            return 406//580
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 176
    }
    
  
    
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let offsetY = -weatherDataTableView.contentOffset.y
//   //     print(offsetY)
//        
//    
//      let headerView = weatherDataTableView.headerView(forSection: 0) as! MainInfoTableViewCell
//      //  print(max(headerView.bounds.height, (headerView.bounds.height)+offsetY))
//      //  headerView.baseHeightConstraint.constant = max(headerView.bounds.height, (headerView.bounds.height)+offsetY)
  //      headerView.setupConstraints(height: max(headerView.bounds.height, (headerView.bounds.height)+offsetY))
//        for cell in weatherDataTableView.visibleCells {
//            if let currentCell = cell as? MainInfoTableViewCell {
//                currentCell.baseHeightConstraint.constant = max(currentCell.bounds.height, currentCell.bounds.height + offsetY)
//            }
//       }
   }
}


