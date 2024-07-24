//
//  JokeViewController.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 23/07/24.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!

    var joke = [Joke](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("JokeViewController")
        tableView.dataSource = self
        loadJokes()
    }
    func loadJokes(){
        JokeAPIClient.getJokes { (result) in
            switch result {
            case .failure(let err):
                print("errr is \(err)")
            case .success(let j):
                print("there are \(j.count) jokes in json file...")
                self.joke = j
            }
        }
    }
}

extension JokeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return joke.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        let index = joke[indexPath.row]
        cell.textLabel?.text = "\(index.id)"
        cell.detailTextLabel?.text = index.punchline
        return cell
    }
}
