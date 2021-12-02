//
//  StartActivityViewController.swift
//  ДВФУПример
//
//  Created by Фам Тхань Хай on 01/12/2021.
//

import UIKit
import CoreLocation
import CoreData
import MapKit

private let image = UIImage(named: "Background")

private let identifier = "ActivityTypeCollectionViewCell"

private let activitiesTypeData: [ActivityTypeCellViewModel] =
[
    ActivityTypeCellViewModel(activityType: "Велосипед", activityTypeImage: image ?? UIImage(), titleForManageState: "На велике"),
    ActivityTypeCellViewModel(activityType: "Бег", activityTypeImage: image ?? UIImage(), titleForManageState: "Бежим"),
    ActivityTypeCellViewModel(activityType: "Ходьба", activityTypeImage: image ?? UIImage(), titleForManageState: "Идем")
]

class StartActivityViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var statesContainer: UIView!
    
    @IBOutlet weak var startActivityStateView: UIView!
    
    @IBOutlet weak var toStartLabel: UILabel!
    @IBOutlet weak var listOfActivitiesType: UICollectionView!
    @IBOutlet weak var startActivityButton: ActivityFEFUButton!
    
    @IBOutlet weak var manageActivityStateView: UIView!
    @IBOutlet weak var typeOfActivityLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    private let coreDataContainer = FEFUCoreDataContainer.instance
    private var previousRouteSegment: MKPolyline?
    private var currentDuration: TimeInterval = TimeInterval()
    private var startValueForTimer: Date?
    private var timer: Timer?
    
    private var activityDistance: CLLocationDistance = CLLocationDistance()
    private var activityDate: Date?
    private var activityDuration: TimeInterval = TimeInterval()
    private var activityType: String?
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    fileprivate var userLocation: CLLocation? {
        didSet {
            guard let userLocation = userLocation else {
                return
            }
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            
            if oldValue != nil {
                activityDistance += userLocation.distance(from: oldValue!)
            }
            
            distanceLabel.text = String(format: "%.2f км", activityDistance / 1000)
            
            mapView.setRegion(region, animated: true)
            
            userLocationsHistory.append(userLocation)
        }
    }
    
    fileprivate var userLocationsHistory: [CLLocation] = [] {
        didSet {
            let coordinates = userLocationsHistory.map { $0.coordinate }
            
            if let previousRoute = previousRouteSegment, !userLocationsHistory.isEmpty {
                mapView.removeOverlay(previousRoute as MKOverlay)
                previousRouteSegment = nil
            }
            
            if userLocationsHistory.isEmpty {
                previousRouteSegment = nil
            }
            
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            route.title = "Ваш маршрут"
            
            previousRouteSegment = route
            
            mapView.addOverlay(route)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        self.title = "Новая активность"
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        listOfActivitiesType.dataSource = self
        listOfActivitiesType.delegate = self
        
        let nib = UINib(nibName: identifier, bundle: nil)
        listOfActivitiesType.register(nib, forCellWithReuseIdentifier: identifier)
        
        commonInit()
    }

    private func commonInit() {
        statesContainer.backgroundColor = .clear
        activityStateInit()
        manageStateInit()
    }
    
    private func activityStateInit() {
        // i think that i can set cornerRadius to container, but in design state views have different height, and i need2do this
        startActivityStateView.layer.cornerRadius = 25
        startActivityStateView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        startActivityStateView.isHidden = false
        
        toStartLabel.text = "Погнали? :)"
        
        startActivityButton.setTitle("Старт", for: .normal)
    }
    
    private func manageStateInit() {
        manageActivityStateView.layer.cornerRadius = 25
        manageActivityStateView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        typeOfActivityLabel.text = "Активность"
        distanceLabel.text = "0.00 км"
        timerLabel.text = "00:00:00"
        manageActivityStateView.isHidden = true
    }
    
    @IBAction func didStartTracking(_ sender: Any) {
        startActivityStateView.isHidden = true
        manageActivityStateView.isHidden = false
        
        activityDate = Date()
        startValueForTimer = Date()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        locationManager.startUpdatingLocation()
    }
    
    @objc private func updateTimer() {
        let currentTime = Date().timeIntervalSince(startValueForTimer!)
        
        currentDuration = currentTime
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        timeFormatter.zeroFormattingBehavior = .pad
        
        timerLabel.text = timeFormatter.string(from: currentTime + activityDuration)
    }
    
    @IBAction func didPauseTracking(_ sender: PauseButton) {
        userLocationsHistory = []
        userLocation = nil
        
        sender.isSelected.toggle()
        if sender.isSelected {
            activityDuration += currentDuration
            currentDuration = TimeInterval()
            timer?.invalidate()
            
            locationManager.stopUpdatingLocation()
        } else {
            startValueForTimer = Date()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func didFinishTracking(_ sender: FinishButton) {
        locationManager.stopUpdatingLocation()
        
        let context = coreDataContainer.context
        let activity = CDActivity(context: context)
        
        activityDuration += currentDuration
        timer?.invalidate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let activityStartTime = dateFormatter.string(from: activityDate!)
        let activityEndTime = dateFormatter.string(from: activityDate! + activityDuration)
        
        activity.type = activityType
        activity.date = activityDate
        activity.distance = activityDistance
        activity.startTime = activityStartTime
        activity.endTime = activityEndTime
        activity.duration = activityDuration
        
        coreDataContainer.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
}

extension StartActivityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            return
        }
    
        userLocation = currentLocation
    }
}

extension StartActivityViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let render = MKPolylineRenderer(polyline: polyline)
            
            render.fillColor = UIColor(named: "ButtonBackgroundColor")
            render.strokeColor = UIColor(named: "ButtonBackgroundColor")
            render.lineWidth = 5
            
            return render
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: "user_icon")
            
            let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "user_icon")
            
            view.image = UIImage(named: "ic_user_location")
            return view
        }
        return nil
    }
}

extension StartActivityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activitiesTypeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let activityTypeData = activitiesTypeData[indexPath.row]
        
        let dequeuedCell = listOfActivitiesType.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        guard let upcastedCell = dequeuedCell as? ActivityTypeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        upcastedCell.bind(activityTypeData)
        
        return upcastedCell
    }
}

extension StartActivityViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as?
            ActivityTypeCollectionViewCell {
            cell.cardView.layer.borderWidth = 2
            cell.cardView.layer.borderColor = UIColor(named: "ButtonBackgroundColor")?.cgColor
            
            activityType = cell.activityType
            typeOfActivityLabel.text = activityType
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ActivityTypeCollectionViewCell {
            cell.cardView.layer.borderWidth = 0
        }
    }

}
