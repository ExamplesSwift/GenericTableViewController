import UIKit
import XCPlayground

struct Episode {
    var title: String
}

struct Seson {
    var cod:  Int
    var name: String
}

final class ItemsViewController<Item> : UITableViewController {
    
    var items: [Item] = []
    let reuseIdentifier = "Cell"
    let configure : (UITableViewCell, Item) -> ()
    
    
    init(items: [Item], configure: @escaping (UITableViewCell, Item) -> ()) {
        self.configure = configure
        super.init(style: .plain)
        self.items = items
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }

}


let sampleEpisodes = [Episode(title: "First Episode"),
                      Episode(title: "Second Episode"),
                      Episode(title: "Third Episode")]

let sampleSeasons = [Seson(cod: 1, name: "Summer"), Seson(cod: 2, name: "Winter"), Seson(cod: 3, name: "Nautum"), Seson(cod: 4, name: "Primavera")]


let episodeVC = ItemsViewController(items: sampleSeasons,configure: {cell, season in
    cell.textLabel?.text = season.name
    cell.detailTextLabel?.text = "\(season.cod)"
})

episodeVC.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)

XCPlaygroundPage.currentPage.liveView = episodeVC.view
