struct Coordinate {
    let longitude: Double
    let latitude: Double
}

struct Playground: Identifiable {
    let id: String
    let name: String
    let addressDescription: String?
    let description: String?
    let coordiante: Coordinate
}

// MARK:- Equatable Extension

extension Coordinate: Equatable {}
extension Playground: Equatable {}

// MARK:- Decodable Extension

extension Coordinate: Decodable {

    enum CodingKeys: String, CodingKey {
        case longitude = "lng"
        case latitude = "lat"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
    }
}

extension Playground: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address = "addressDescription"
        case description
        case position
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.addressDescription = try container.decodeIfPresent(String.self, forKey: .address)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.coordiante = try container.decode(Coordinate.self, forKey: .position)
    }
}

