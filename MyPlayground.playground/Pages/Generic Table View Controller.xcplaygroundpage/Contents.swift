import UIKit
import XCPlayground

struct Episode {
    var title: String
}

final class EpisodesViewController<Item> : UITableViewController {
    
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

let episodeVC = EpisodesViewController(items: sampleEpisodes,configure: {cell, item in
    cell.textLabel?.text = item.title
})

episodeVC.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)

XCPlaygroundPage.currentPage.liveView = episodeVC.view
