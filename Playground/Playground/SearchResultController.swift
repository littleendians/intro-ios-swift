import UIKit

fileprivate enum SearchResultControllerState {
    case presenting([Playground])
    case filtering([Playground], [Playground], String)
    
    fileprivate enum Event {
        case didSelectAtIndex(Int)
        case didFilterWithText(String)
        case didUpdateWithData([Playground])
    }
    
    fileprivate enum Command {
        case reloadData
        case present(Playground)
    }
    
    static let initialState = SearchResultControllerState.presenting([])
    
    var count: Int {
        switch self {
        case .presenting(let playgrounds):
            return playgrounds.count
        case .filtering(_, let playgrounds, _):
            return playgrounds.count
        }
    }
    
    mutating func handleEvent(_ event: Event) -> Command? {
        switch (self, event) {
        case (.presenting, .didUpdateWithData(let data)),
             (.filtering, .didUpdateWithData(let data)):
            self = .presenting(data)
            return .reloadData
        case (_, .didSelectAtIndex(let index)):
            let object = self.object(at: index)
            return .present(object)
        case (.presenting(let data), .didFilterWithText(let text)),
             (.filtering(let data, _, _), .didFilterWithText(let text)):
            if text.isEmpty {
                self = .presenting(data)
            } else {
                let filtered = data.filter({ $0.name.contains(text) })
                self = .filtering(data, filtered, text)
            }
            return .reloadData
        }
    }
    
    func object(at index: Int) -> Playground {
        switch self {
        case .presenting(let playgrounds):
            return playgrounds[index]
        case .filtering(_, let playgrounds, _):
            return playgrounds[index]
        }
    }
    
}

protocol SearchResultControllerDelegate: class {
    func didSelect(playground: Playground, from: SearchResultController)
}

final class SearchResultController: UITableViewController {
    
    let kCellIdentifier = "CellIdentifier"
    
    weak var delegate: SearchResultControllerDelegate?
    
    fileprivate var state = SearchResultControllerState.initialState
    
    fileprivate func handle(event: SearchResultControllerState.Event) {
        guard let command = state.handleEvent(event) else { return }
        
        switch command {
        case .present(let playground):
            delegate?.didSelect(playground: playground, from: self)
        case .reloadData:
            tableView.reloadData()
        }
    }
    
    func setData(_ data: [Playground]) {
        handle(event: .didUpdateWithData(data))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        cell.configure(with: state.object(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handle(event: .didSelectAtIndex(indexPath.row))
    }
}


extension SearchResultController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if self.view.isHidden {
           self.view.isHidden = false
        }
        
        if let text = searchController.searchBar.text, searchController.isActive {
            handle(event: .didFilterWithText(text))
        }
    }
    
}

private extension UITableViewCell {
    
    func configure(with playground: Playground) {
        self.textLabel?.text = playground.name
        self.detailTextLabel?.text = playground.description
        self.imageView?.image = #imageLiteral(resourceName: "MapPinCalloutLeft")
    }
    
}
