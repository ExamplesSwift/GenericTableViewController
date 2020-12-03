import UIKit
import XCPlayground

struct Episode {
    var title: String
}

struct Seson {
    var cod:  Int
    var name: String
}

final class ItemsViewController<Item, Cell: UITableViewCell> : UITableViewController {
    
    var items: [Item] = []
    let reuseIdentifier = "Cell"
    let configure : (Cell, Item) -> ()
    var didSelect: (Item)->() = {_ in }
    
    
    init(items: [Item], configure: @escaping (Cell, Item) -> ()) {
        self.configure = configure
        super.init(style: .plain)
        self.items = items
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }

}

let sampleEpisodes = [Episode(title: "First Episode"),
                      Episode(title: "Second Episode"),
                      Episode(title: "Third Episode")]

let sampleSeasons = [Seson(cod: 1, name: "Summer"),
                     Seson(cod: 2, name: "Winter"),
                     Seson(cod: 3, name: "Nautum"),
                     Seson(cod: 4, name: "Primavera")]

final class SeasonCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let episodeVC = ItemsViewController(items: sampleSeasons, configure: { (cell: SeasonCell, season) in
    cell.textLabel?.text = season.name
    cell.detailTextLabel?.text = "\(season.cod)"
})

let nc = UINavigationController(rootViewController: episodeVC)

episodeVC.didSelect = { item in
    let detailVC = ItemsViewController(items: sampleEpisodes) { (cell, episode) in
        cell.textLabel?.text = episode.title
    }
    detailVC.title = "Detalles"
    nc.pushViewController(detailVC, animated: true)
}

episodeVC.title = "Season"



nc.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)

XCPlaygroundPage.currentPage.liveView = nc.view
