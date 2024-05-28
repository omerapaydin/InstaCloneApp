//
//  FeedViewController.swift
//  InstaCloneApp
//
//  Created by Ömer on 25.05.2024.
//

import UIKit

class FeedViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.commentLabel.text = "çok iyi"
        cell.imageVieww.image = UIImage(named: "select")
        cell.likeLabel.text = "0"
        cell.userEmailLabel.text = "omerapaydin"
        return cell
        
    }
    


}
