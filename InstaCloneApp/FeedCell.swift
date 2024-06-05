//
//  FeedCell.swift
//  InstaCloneApp
//
//  Created by Ömer on 28.05.2024.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var imageVieww: UIImageView!
    
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
        
        
        
    }
}
