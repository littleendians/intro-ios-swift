struct Coordinate {
    let longitude: Double
    let latitude: Double
}

extension Coordinate: Equatable {
    static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
}

struct Playground {
    let id: Int
    let name: String
    let addressDescription: String?
    let description: String?
    let coordiante: Coordinate
}

extension Playground: Equatable {
    static func ==(lhs: Playground, rhs: Playground) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.addressDescription == rhs.addressDescription &&
            lhs.description == rhs.description &&
            lhs.coordiante == rhs.coordiante
    }
}

// MARK:- Custom Failing Initializer Extension
extension Playground {
    
    init?(attributes: [String:Any]) {
        guard let properties = attributes["properties"] as? [String: AnyObject] else {
            return nil
        }
        
        guard let id = properties["id"] as? Int else {
            return nil
        }
        
        guard let addressDescription = properties["adressebeskrivelse"] as? String else {
            return nil
        }
        
        guard let description = properties["beskrivelse"] as? String else {
            return nil
        }
        
        guard let name = properties["navn"] as? String else {
            return nil
        }
        
        
        guard let geo = attributes["geometry"] as? [String: AnyObject] else {
            return nil
        }
        
        guard let coordinates = geo["coordinates"] as? [[Double]] else {
            return nil
        }
        
        let lat: Double = coordinates[0][1]
        let long: Double = coordinates[0][0]
        
        self.id = id
        self.name = name
        self.description = description
        self.addressDescription = addressDescription
        self.coordiante = Coordinate(longitude: long, latitude: lat)
    }
}

