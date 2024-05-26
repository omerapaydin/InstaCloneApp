//
//  UploadViewController.swift
//  InstaCloneApp
//
//  Created by Ömer on 25.05.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.isUserInteractionEnabled = true
        let gestureImage = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureImage)
        
        
        
    }
    
    @objc func chooseImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func makeAlert(titleInput:String , messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
    
    @IBAction func uploadClicked(_ sender: Any) {
        let storage = Storage.storage()
        
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            
            imageReferance.putData(data) { (metadata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else{
                    
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            
                            var firestoneReferance : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl! , "posteBy" : Auth.auth().currentUser!.email! , "postComment" : self.commentText.text! , "date" : FieldValue.serverTimestamp() , "likes" : 0] as [String : Any]
                            
                            firestoneReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                
                                if error != nil {
                                    
                                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                                    
                                }else {
                                    
                                    self.imageView.image = UIImage(named: "select")
                                    self.commentText.text = ""
                                    
                                    self.tabBarController?.selectedIndex = 0
                                    
                                    
                                }
                                
                            })
                            
                            
                            
                            
                            
                            
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
  

}
