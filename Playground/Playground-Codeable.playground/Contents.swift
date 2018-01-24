import Foundation

struct PlaygroundContainer {
    let type: String
    let totalFeatures: Int
    let playgrounds: [Playground]
}

extension PlaygroundContainer: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case totalFeatures = "totalFeatures"
        case playgrounds = "features"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.totalFeatures = try container.decode(Int.self, forKey: .totalFeatures)
        
        var items: [Playground] = []
        var features = try container.nestedUnkeyedContainer(forKey: .playgrounds)
        while (!features.isAtEnd) {
            let playground = try features.decode(Playground.self)
            items.append(playground)
        }
        self.playgrounds = items
    }
}

struct Playground {
    let id: Int
    let name: String
    let addressDescription: String?
    let description: String?
    var coordinate: Coordinate?

    struct Coordinate: Equatable {
        var latitude: Double
        var longitude: Double

        static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
            return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
        }
    }
}

extension Playground: CustomDebugStringConvertible {

    var debugDescription: String { return "\(id) - \(name), \(description ?? "")" }
}

extension Playground: Equatable {

    static func ==(lhs: Playground, rhs: Playground) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.addressDescription == rhs.addressDescription &&
            lhs.description == rhs.description &&
            lhs.coordinate == rhs.coordinate
    }
}

extension Playground: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case geometry
        case properties
    }

    enum GeometryCodingKeys: String, CodingKey {
        case coordinates
    }

    enum PropertiesCodingKeys: String, CodingKey {
        case id
        case name = "navn"
        case addressDescription = "adressebeskrivelse"
        case description = "beskrivelse"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var geoContainer = try container
            .nestedContainer(keyedBy: GeometryCodingKeys.self, forKey: .geometry)
            .nestedUnkeyedContainer(forKey: .coordinates)
        var subContainer = try geoContainer.nestedUnkeyedContainer()
        if subContainer.count == 2 {
            var coordinate: [Double] = []
            while !subContainer.isAtEnd {
                let value = try subContainer.decode(Double.self)
                coordinate.append(value)
            }
            self.coordinate = Coordinate(latitude: coordinate[0], longitude: coordinate[1])
        } else {
            self.coordinate = nil
        }
        
        let propertiesContainer = try container.nestedContainer(keyedBy: PropertiesCodingKeys.self,
                                                                forKey: .properties)
        self.id = try propertiesContainer.decode(Int.self, forKey: .id)
        self.name = try propertiesContainer.decode(String.self, forKey: .name)
        self.description = try propertiesContainer.decodeIfPresent(String.self, forKey: .description)
        self.addressDescription = try propertiesContainer.decodeIfPresent(String.self, forKey: .addressDescription)
    }

}

let json = """
{
  "type": "FeatureCollection",
  "totalFeatures": 134,
  "features": [
    {
      "type": "Feature",
      "id": "legeplads.1",
      "geometry": {
        "type": "MultiPoint",
        "coordinates": [
          [
            12.589685450548627,
            55.6767238736979
          ]
        ]
      },
      "geometry_name": "wkb_geometry",
      "properties": {
        "id": 131,
        "legeplads_id": 53,
        "navn": "Havnegades trampolinpromenade",
        "adressebeskrivelse": "Havnegade",
        "bydel": "Indre By",
        "legeplads_type": "Legeplads",
        "aldersgruppe": "Alle",
        "ejer": "Københavns kommune",
        "beskrivelse": "Hop i trampolin med havnekig.",
        "link": "http://www.kk.dk/Borger/ByOgTrafik/Anlaegsprojekter/GaderOgVeje/Havnegade.aspx",
        "link_kkdk": "http://www.kk.dk/Borger/ByOgTrafik/Anlaegsprojekter/GaderOgVeje/Havnegade.aspx",
        "graffitirenhold": "ja",
        "graffitirenhold_id": 53
      }
    },
    {
      "type": "Feature",
      "id": "legeplads.2",
      "geometry": {
        "type": "MultiPoint",
        "coordinates": [
          [
            12.588571683898572,
            55.669599877562
          ]
        ]
      },
      "geometry_name": "wkb_geometry",
      "properties": {
        "id": 13,
        "legeplads_id": 14,
        "navn": "Legepladsen på Christianshavns Vold - Panterens Bastion",
        "adressebeskrivelse": "på Panterens Bastion",
        "bydel": "Indre By",
        "legeplads_type": "Legeplads",
        "aldersgruppe": "0-6",
        "ejer": "Københavns kommune",
        "beskrivelse": "Fredelig, grøn plet til leg og grill.",
        "link": "http://kk.sites.itera.dk/apps/kk_legepladser_ny/index.asp?mode=detalje&id=65",
        "link_kkdk": "http://kk.sites.itera.dk/apps/kk_legepladser_ny/index.asp?mode=detalje&id=65",
        "graffitirenhold": "ja",
        "graffitirenhold_id": 14
      }
    },
    {
      "type": "Feature",
      "id": "legeplads.3",
      "geometry": {
        "type": "MultiPoint",
        "coordinates": [
          [
            12.579092466356643,
            55.690462674122244
          ]
        ]
      },
      "geometry_name": "wkb_geometry",
      "properties": {
        "id": 10,
        "legeplads_id": 4,
        "navn": "Legepladsen i Østre Anlæg ved Malmøgade",
        "adressebeskrivelse": "Stockholmsgade 24",
        "bydel": "Indre By",
        "legeplads_type": "Legeplads",
        "aldersgruppe": "0-14",
        "ejer": "Københavns kommune",
        "beskrivelse": "Populært, grønt åndehul med kælkebakke",
        "link": "http://kk.sites.itera.dk/apps/kk_legepladser_ny/index.asp?mode=detalje&id=114",
        "link_kkdk": "http://kk.sites.itera.dk/apps/kk_legepladser_ny/index.asp?mode=detalje&id=114",
        "graffitirenhold": "ja",
        "graffitirenhold_id": 4
      }
    }
  ]
}
""".data(using: String.Encoding.utf16)!

let decoder = JSONDecoder()

let decodedStore = try? decoder.decode(PlaygroundContainer.self, from: json)
print(decodedStore?.playgrounds)

