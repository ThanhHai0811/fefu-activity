//
//  ActivityDetailsViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 25/10/2021.
//

import UIKit

class ActivityDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var StartButton: UIButton!
    let ArrayDay = ["Вчера","Май 2022 года"]
    let ArrayKm = ["14.32 км","14.32 км"]
    let ArrayTime1 = ["2 часа 46 минут","2 часа 46 минут"]
    let ArrayVehicle = ["Велосипед","Велосипед"]
    let ArrayTime2 = ["14 часов назад","14 часов назад"]
    let ArrayTime3 = ["1 ч 42 мин","11 ч 42 мин"]
    let ArrayTime4 = ["Старт 14:49 · Финиш 16:31","Старт 14:49 · Финиш 16:31"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Активности"
        StartButton.setTitle("Старт", for: .normal)
        StartButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        let nidName = UINib(nibName: "Table1ViewCell", bundle: nil)
        tableView.register(nidName, forCellReuseIdentifier: "table1ViewCell")
        commonInit1()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayDay.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table1ViewCell", for: indexPath) as! Table1ViewCell
        cell.commonInit(ArrayDay[indexPath.item], km:ArrayKm[indexPath.item], time1: ArrayTime1[indexPath.item], vehicle: ArrayVehicle[indexPath.item], time2: ArrayTime2[indexPath.item])
        return cell
    }
    private func commonInit1(){
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVCViewController(nibName: "DetailVCViewController", bundle: nil)
        vc.commonInit2(ArrayVehicle[indexPath.item], image: "bicycle.circle.fill", km: ArrayKm[indexPath.item], time2: ArrayTime2[indexPath.item], time3: ArrayTime3[indexPath.item], vehicle: ArrayVehicle[indexPath.item], time4: ArrayTime4[indexPath.item], time5: ArrayTime2[indexPath.item])
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
