//
//  OtherInfoTableViewCell.swift
//  WeatherMainProject
//
//  Created by Алексей on 27.07.21.
//

import UIKit

final class OtherInfoTableViewCell: UITableViewCell {

    @IBOutlet private weak var otherInfoTableView: UITableView!
    private var dataSourceOtherInfo: [OtherInfoModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        otherInfoTableView.dataSource = self
        otherInfoTableView.delegate = self
        
        otherInfoTableView.register(cellType: OtherInfoCell.self)
        
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setupCell(model: [OtherInfoModel]) {
        dataSourceOtherInfo = model
        otherInfoTableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension OtherInfoTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourceOtherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = otherInfoTableView.dequeueReusableCell(with: OtherInfoCell.self, for: indexPath)
        cell.setupOtherInfocell(model: dataSourceOtherInfo[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}
