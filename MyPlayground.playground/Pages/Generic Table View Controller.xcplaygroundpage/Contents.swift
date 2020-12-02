import UIKit
import XCPlayground

struct Episode {
    var title: String
}

final class EpisodesViewController : UITableViewController {
    
    var episodes: [Episode] = []
    let reuseIdentifier = "Cell"
    
    init(episodes: [Episode]) {
        super.init(style: .plain)
        self.episodes = episodes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
                let item = episodes[indexPath.row]
        cell.textLabel?.text = item.title
                return cell
    }

}


let sampleEpisodes = [Episode(title: "First Episode"),
                      Episode(title: "Second Episode"),
                      Episode(title: "Third Episode")]

let episodeVC = EpisodesViewController(episodes: sampleEpisodes)

episodeVC.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)

XCPlaygroundPage.currentPage.liveView = episodeVC.view
