import Foundation
import MapKit

final class PlaygroundAnnotation: NSObject, MKAnnotation {

    let id: String

    var coordinate: CLLocationCoordinate2D
    
    let title: String?
    
    let subtitle: String?

    init(playground: Playground) {
        self.id = playground.id
        self.coordinate =  CLLocationCoordinate2D(latitude: playground.coordiante.latitude, longitude: playground.coordiante.longitude)
        self.title = playground.name
        self.subtitle = playground.description
    }
    
}

