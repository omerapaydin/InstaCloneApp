//
//  FeedViewController.swift
//  InstaCloneApp
//
//  Created by Ömer on 25.05.2024.
//

import UIKit
import Firebase

class FeedViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getDataFromFirestone()

        
    }
    
    
    
    func getDataFromFirestone(){
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Posts").addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }else {
                
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let posteBy = document.get("posteBy") as? String{
                            self.userEmailArray.append(posteBy)
                        }
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.userImageArray.append(imageUrl)
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                    
                }
                
            }
        }
        
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.imageVieww.image = UIImage(named: "select")
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        return cell
        
    }
    


}
