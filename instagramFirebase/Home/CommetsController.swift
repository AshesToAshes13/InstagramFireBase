//
//  CommetsController.swift
//  instagramFirebase
//
//  Created by Егор Бамбуров on 02.08.2018.
//  Copyright © 2018 Егор Бамбуров. All rights reserved.
//

import UIKit
import Firebase

class CommentController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CommentInputAccessoryViewDelegate {
    
    let cellId = "cellId"
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .interactive
        navigationItem.title = NSLocalizedString("CommentScreenTitle", comment: "Комментарии")
        self.navigationController?.navigationBar.tintColor = .black
        collectionView?.register(CommentCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        fetchComment()
    }
    
    var comments = [Comment]()
    private func fetchComment() {
        guard let postId = self.post?.id else {return}
        let ref = Database.database().reference().child("comments").child(postId)
        ref.observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            Database.fetchUserWithUID(uid: uid, completion: { (user) in
                let comment = Comment(user: user, dictionary: dictionary)
                self.comments.append(comment)
                self.collectionView?.reloadData()
            })
        }) { (err) in
            print("Failed to fetch comments:", err)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommentCell
        cell.comment = self.comments[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = CommentCell(frame: frame)
        dummyCell.comment = comments[indexPath.item]
        dummyCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1500)
        let estimatedSize = dummyCell.systemLayoutSizeFitting(targetSize)
        let height = max(40 + 8 + 8, estimatedSize.height)
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
   lazy var containerView: UIView = {
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    let commentInputAccessoryView = CommentInputAccessoryView(frame: frame)
    commentInputAccessoryView.delegate = self
    return commentInputAccessoryView
    }()
    
    func didSubmit(for comment: String) {
        print(321)
        guard let postId = self.post?.id else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let crearionDate = Date().timeIntervalSince1970
        let values = ["commentText": comment, "creationDate": crearionDate, "uid": uid] as [String : Any]
        Database.database().reference().child("comments").child(postId).childByAutoId().updateChildValues(values) { (err, reference) in
            if let err = err {
                print("failed to upload comment to DB:", err)
            }
        }
        
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
   
    override var canBecomeFirstResponder: Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
