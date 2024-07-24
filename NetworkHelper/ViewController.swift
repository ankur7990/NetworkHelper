//
//  ViewController.swift
//  NetworkHelper
//
//  Created by Ankur Pipaliya on 22/07/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadImagePressed: UIBarButtonItem!
    let urlString = "https://media.istockphoto.com/id/672350552/photo/ganesha.webp?b=1&s=170667a&w=0&k=20&c=Z70yVLRPoUqJ6K-KovEgiy7CgZTTbxMVUezOhGQGYa4="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let networkhelper = NetworkHelper()
        //NetworkHelper.shared
       // loadJokes()
//        loadPodcast()
        
    }

   
    @IBAction func loadImagePressed(_ sender: UIBarButtonItem) {
        NetworkHelper.shared.performDataTask(with: urlString) { (result) in
            switch result{
            case .failure(let error):
                print("app error \(error)")
            case .success(let data):
                // we are here coming from the network helper class which is background thread
                // or some global thread.
                // and we will assign data to UI to display picture so thread chage
                // use dispatch queue and go to main thread.
                
                let imageData = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView.image = imageData
                }
            }
        }
    }
    
}

