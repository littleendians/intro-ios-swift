import Foundation

final class PlaygroundFileService: PlaygroundService {

    func fetchPlaygrounds(completion: @escaping ((Result<[Playground], Error>) -> Void)) {
        guard let url = Bundle.main.url(forResource: "Copenhagen", withExtension: "json") else {
            // TODO construct error
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let playgrounds = try decoder.decode([Playground].self, from: data)
            completion(.success(playgrounds))
        } catch {
            completion(.failure(error))
        }
    }
}
