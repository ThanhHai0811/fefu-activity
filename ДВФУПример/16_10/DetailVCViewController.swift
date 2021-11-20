//
//  DetailVCViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 29/10/2021.
//

import UIKit

class DetailVCViewController: UIViewController {
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var Time2Label: UILabel!
    @IBOutlet weak var Time3Label: UILabel!
    @IBOutlet weak var VehicleLabel: UILabel!
    @IBOutlet weak var Time4Label: UILabel!
    @IBOutlet weak var Time5Label: UILabel!
    var imageName: String!
    var kmlabel: String!
    var time2label: String!
    var time3label: String!
    var vehiclelabel: String!
    var time4label: String!
    var time5label: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Image.image = UIImage(systemName: self.imageName)
        kmLabel.text = self.kmlabel
        Time2Label.text = self.time2label
        Time3Label.text = self.time3label
        VehicleLabel.text = self.vehiclelabel
        Time4Label.text = self.time4label
        Time5Label.text = self.time5label
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: nil)
        commonInit1()
    }
    private func commonInit1(){
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    func commonInit2(_ title:String, image: String, km:String, time2: String, time3: String, vehicle: String, time4: String, time5: String){
        self.title = title
        self.imageName = image
        self.kmlabel = km
        self.time2label = time2
        self.time3label = time3
        self.vehiclelabel = vehicle
        self.time4label = time4
        self.time5label = time5
    }
}
