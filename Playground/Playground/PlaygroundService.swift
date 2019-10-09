
protocol PlaygroundService {
    
    func fetchPlaygrounds(completion: @escaping ((Result<[Playground], Error>) -> Void))

}
