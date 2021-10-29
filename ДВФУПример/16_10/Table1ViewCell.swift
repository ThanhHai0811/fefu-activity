//
//  Table1ViewCell.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 28/10/2021.
//

import UIKit

class Table1ViewCell: UITableViewCell {


    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var KmLabel: UILabel!
    @IBOutlet weak var Time1Label: UILabel!
    @IBOutlet weak var VehicleLabel: UILabel!
    @IBOutlet weak var Time2Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func commonInit(_ day: String,km:String, time1: String, vehicle:String, time2:String ){
        DayLabel.text = day
        KmLabel.text = km
        Time1Label.text = time1
        VehicleLabel.text = vehicle
        Time2Label.text = time2
    }
}
