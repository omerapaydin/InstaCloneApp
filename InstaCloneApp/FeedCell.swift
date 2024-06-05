//
//  FeedCell.swift
//  InstaCloneApp
//
//  Created by Ömer on 28.05.2024.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var imageVieww: UIImageView!
    
    @IBOutlet weak var documentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeClicked(_ sender: Any) {
        
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!){
            
            
            let likeStore = ["likes": likeCount + 1] as [String : Any]
            
            fireStoreDatabase.collection("Posts").document(documentLabel.text!).setData(likeStore, merge: true)
        }
        
        
        
       
        
        
        
    }
}
