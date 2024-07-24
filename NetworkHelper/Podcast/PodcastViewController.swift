//
//  PodcastViewController.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 23/07/24.
//

import UIKit

class PodcastViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    var podcast = [Podcast]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PodcastViewController")
        tableView.dataSource = self
        loadPodcast()
    }
    func loadPodcast(){
        PodcastAPIClient.getPodcast { (result) in
            switch result{
            case .failure(let appError):
                print("appError \(appError)")
            case .success(let podcasts):
                print("there was \(podcasts.count) podcast found...")
                self.podcast = podcasts
            }
            
        }
    }
}
extension PodcastViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcast.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath)
        
        let index = podcast[indexPath.row]
        
        cell.textLabel?.text = index.artistName
        cell.detailTextLabel?.text =  index.collectionName
        
        return cell
    }
}
