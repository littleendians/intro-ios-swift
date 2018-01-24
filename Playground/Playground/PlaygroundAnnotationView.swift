import Foundation
import MapKit

final class PlaygroundAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = true
        self.image = #imageLiteral(resourceName: "MapPin")
        self.leftCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "MapPinCalloutLeft"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
