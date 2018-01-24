import Foundation

class PlaygroundService {
    
    func fetchPlaygrounds(completion: @escaping (([Playground]) -> Void)) {
        var playgrounds = [Playground]()
        
        if let url = URL(string: "http://wfs-kbhkort.kk.dk/k101/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=k101:legeplads&outputFormat=json&SRSNAME=EPSG:4326") {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    if let features = json?["features"] as? [Any] {
                        let output = features.flatMap({ (openData) -> Playground? in
                            if let open = openData as? [String: Any] {
                                return Playground(attributes: open)
                            }
                            return nil
                        })
                        playgrounds.append(contentsOf: output)
                    }
                }
                DispatchQueue.main.async {
                    completion(playgrounds)
                }
                }.resume()
            
        }
    }

}
