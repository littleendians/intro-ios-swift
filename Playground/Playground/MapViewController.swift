import UIKit
import MapKit
import CoreLocation
import os.log

final class MapViewController: UIViewController {

    private let kCopenHagenCenterCoordinate = CLLocationCoordinate2D(latitude: 55.676111, longitude: 12.568333)
    
    private let kAnnotationReuseIdentifier = "AnnotationView"
    
    private var locationManager: CLLocationManager?
    
    private let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "service")
    
    private lazy var service: PlaygroundService = {
        let service = PlaygroundFileService()
        return service
    }()
    
    fileprivate lazy var searchContoller: UISearchController = {
        let searchContoller = UISearchController(searchResultsController: resultController)
        searchContoller.searchResultsUpdater = resultController
        searchContoller.hidesNavigationBarDuringPresentation = false
        return searchContoller
    }()
    
    private lazy var resultController: SearchResultController = {
        let controller = SearchResultController()
        controller.delegate = self
        return controller
    }()

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        mapView.register(PlaygroundAnnotationView.self, forAnnotationViewWithReuseIdentifier: kAnnotationReuseIdentifier)
        center(at: kCopenHagenCenterCoordinate)
        
        let searchBar = searchContoller.searchBar
        self.navigationItem.titleView = searchBar
        searchBar.sizeToFit()
        
        self.definesPresentationContext = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager?.requestWhenInUseAuthorization()
            }
            locationManager?.delegate = self
            locationManager?.requestLocation()
        }
        
        service.fetchPlaygrounds { [weak self] (result) in
            switch result {
            case let .success(playgrounds):
                let annotations = playgrounds.map(PlaygroundAnnotation.init)
                self?.mapView.addAnnotations(annotations)
                self?.resultController.setData(playgrounds)
            case let .failure(error):
                os_log("Error occured while calling fetchPlaygrounds: %@", error.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        locationManager?.stopUpdatingLocation()
    }

    func center(at coordinate: CLLocationCoordinate2D) {
        mapView.setRegion(MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
    }
    
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PlaygroundAnnotation {
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: kAnnotationReuseIdentifier, for: annotation)
            return view
        }
        return nil
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        manager.stopUpdatingLocation()
        center(at: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        os_log("Error occured while calling CLLocationManager: %@", error.localizedDescription)
    }
    
}


extension MapViewController: SearchResultControllerDelegate {
    
    func didSelect(playground: Playground, from: SearchResultController) {
        let annotations = mapView.annotations.filter { (annotation) -> Bool in
            guard let annotation = annotation as? PlaygroundAnnotation,
                annotation.id == playground.id else { return false }
            return true
        }
        
        guard let annotation = annotations.first else { return }
        center(at: annotation.coordinate)
        mapView.selectAnnotation(annotation, animated: true)
        searchContoller.isActive = false
    }
}
