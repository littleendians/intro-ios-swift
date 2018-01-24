import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {

    let kAnnotationReuseIdentifier = "AnnotationView"
    
    var locationManager: CLLocationManager?
    
    lazy var service = PlaygroundService()
    
    var searchContoller: UISearchController?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let controller = SearchResultController(nibName: nil, bundle: nil)
        controller.delegate = self
        
        searchContoller = UISearchController(searchResultsController: controller)
        searchContoller?.searchResultsUpdater = controller
        searchContoller?.dimsBackgroundDuringPresentation = false
        searchContoller?.hidesNavigationBarDuringPresentation = false
        if let searchBar = searchContoller?.searchBar {
            self.navigationItem.titleView = searchBar
            searchBar.sizeToFit()
        }
        self.definesPresentationContext = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager?.requestWhenInUseAuthorization()
            }
            locationManager?.delegate = self
            locationManager?.requestLocation()
        }
        
        service.fetchPlaygrounds { [weak self] (playgrounds) in
            let annotations = playgrounds.map(PlaygroundAnnotation.init)
            self?.mapView.addAnnotations(annotations)
            controller.setData(playgrounds)
        }
        
        mapView.register(PlaygroundAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: kAnnotationReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        locationManager?.stopUpdatingLocation()
    }

    func center(at coordinate: CLLocationCoordinate2D) {
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, 500, 500), animated: true)
    }
    
}


extension MapViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PlaygroundAnnotation {
            // dequeueReusableAnnotationViewWithAnnotation is part of the Reusable+Additionals
            // extension and not part of the standard API.
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: kAnnotationReuseIdentifier,
                                                             for: annotation)
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
        assertionFailure("Stop press - we got an error: \(error.localizedDescription)")
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
        searchContoller?.isActive = false
    }
}
