//
//  FeedViewController.swift
//  InstaCloneApp
//
//  Created by Ömer on 25.05.2024.
//

import UIKit
import Firebase
import SDWebImage
import SDWebImageMapKit

class FeedViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getDataFromFirestone()

        
    }
    
    
    
    func getDataFromFirestone(){
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }else {
                
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
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
        cell.imageVieww.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        return cell
        
    }
    


}
