import Foundation

final class PlaygroundFileService: PlaygroundService {
    
    func fetchPlaygrounds(completion: @escaping ((Result<[Playground], Error>) -> Void)) {
        // Here we force unwrap which in should be avoided as the app will crash
        // if no URL can be constructed for the given resource.
        let url = Bundle.main.url(forResource: "Copenhagen", withExtension: "json")!

        completion(Result.init { () -> [Playground] in
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Playground].self, from: data)
        })
    }
}
