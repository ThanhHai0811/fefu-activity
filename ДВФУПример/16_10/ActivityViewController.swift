//
//  ActivityViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 25/10/2021.
//

import UIKit
//struct ActivitiesTableViewModel{
//    let date: String
//    let activities: [ActivitiesTableViewCellViewModel]
//}

class ActivityViewController: UIViewController {

    @IBOutlet weak var StateTitle: UILabel!
    @IBOutlet weak var StateDescription: UILabel!
    @IBOutlet weak var StartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Активности"
        StateTitle.text = "Время потренить"
        StateDescription.text = "Нажимай на кнопку ниже и начинаем трекать активность"
        StartButton.setTitle("Старт", for: .normal)
        StartButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
    }
    
    @IBAction func DidTapButton(_ sender: Any) {
        let ProfileView = ActivityDetailsViewController(nibName: "ActivityDetailsViewController", bundle: nil)
        navigationController?.pushViewController(ProfileView, animated: true)
    }
}
