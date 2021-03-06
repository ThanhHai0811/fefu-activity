import UIKit
import CoreData

struct ActivitiesTableViewModel {
    let date: String
    let activities: [ActivityTableViewCellViewModel]
}

class ActivityDetailsViewController: UIViewController {
    
    private var data: [ActivitiesTableViewModel] = [ActivitiesTableViewModel]()
    
    @IBOutlet weak var startButton: ActivityFEFUButton!
    @IBOutlet weak var emptyStateTitle: UILabel!
    @IBOutlet weak var emptyStateDescription: UILabel!
    @IBOutlet weak var emptyStateView: UIView!
    
    @IBOutlet weak var listOfActivities: UITableView!
    
    private let CDController: CDActivityController = CDActivityController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
        self.listOfActivities.reloadData()
    }
    
    private func fetch() {
        do {
            let rawActivities = try CDController.fetch()
            let activitiesViewModels: [ActivityTableViewCellViewModel] = rawActivities.map { activity in
            let image = UIImage(systemName: "bicycle.circle.fill") ?? UIImage()
                
            return ActivityTableViewCellViewModel(distance: activity.distance ?? "",
                                         duration: activity.duration ?? "",
                                         activityType: activity.type ?? "",
                                         startDate: activity.date ?? "",
                                         icon: image,
                                         startTime: activity.startTime ?? "",
                                         endTime: activity.endTime ?? "")
            }
            
            let groupedActivitiesByDate = Dictionary(grouping: activitiesViewModels) { activityVM in
                return activityVM.startDate
            }
            
            self.data = groupedActivitiesByDate.map { (key, values) in
                return ActivitiesTableViewModel(date: key, activities: values)
            }
            
            
        } catch {
            print(error)
        }
    }
    
    private func createDateComponents(_ activityDate: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: activityDate)
        return calendar.date(from: components) ?? Date()
    }
    
    private func commonInit() {
        self.title = "????????????????????"
        
        startButton.setTitle("??????????", for: .normal)
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        emptyStateTitle.text = "?????????? ??????????????????"
        emptyStateDescription.text = "?????????????? ???? ???????????? ???????? ?? ???????????????? ?????????????? ????????????????????"
        emptyStateView.backgroundColor = .clear
        
        listOfActivities.dataSource = self
        listOfActivities.delegate = self
        
        listOfActivities.register(UINib(nibName: "Table1ViewCell", bundle: nil), forCellReuseIdentifier: "Table1ViewCell")
        
        listOfActivities.separatorStyle = .none
        listOfActivities.backgroundColor = .clear
        
        emptyStateView.isHidden = self.data.isEmpty
        listOfActivities.isHidden = !self.data.isEmpty
    }
    
    @IBAction func didStartActivity(_ sender: Any) {
        let startActivityController = StartActivityViewController(nibName: "StartActivityViewController", bundle: nil)
        
        navigationController?.pushViewController(startActivityController, animated: true)
    }
}



extension ActivityDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let DetailVCView = DetailVCViewController(nibName: "DetailVCViewController", bundle: nil)

        let activity = self.data[indexPath.section].activities[indexPath.row]
        DetailVCView.model = activity
        
        navigationController?.pushViewController(DetailVCView, animated: true)
    }
}



extension ActivityDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.font = .boldSystemFont(ofSize: 20)
        
        header.text = data[section].date
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let activityData = self.data[indexPath.section].activities[indexPath.row]
        
        let dequeuedCell = listOfActivities.dequeueReusableCell(withIdentifier: "Table1ViewCell", for: indexPath)
        
        guard let upcastedCell = dequeuedCell as? Table1ViewCell else {
            return UITableViewCell()
        }
        
        upcastedCell.bind(activityData)
        
        return upcastedCell
    }
    
    
}
