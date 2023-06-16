//
//  HomeTableViewCell.swift
//  TutorialProject
//
//  Created by USER on 14/06/2023.
//

import UIKit
import Alamofire
class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var createdAtLb: UILabel!
    @IBOutlet weak var authorNameLb: UILabel!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var contentLb: UILabel!
    @IBOutlet weak var pinBtn: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        resetData()
        authorAvatarImageView.layer.cornerRadius = authorAvatarImageView.bounds.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetData()
    }
    
    private func resetData() {
        contentLb.text = nil
        authorAvatarImageView.image = nil
        createdAtLb.text = nil
        titleLb.text = nil
        authorNameLb.text = nil
    }
    
    func bindData(post: PostGetEntity) {
        contentLb.text = post.content
        
        if let createdAt = post.author?.createdat {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: createdAt) {
                let formatter2 = DateFormatter()
                formatter2.locale = Locale(identifier: "en_US_POSIX")
                formatter2.dateFormat = "dd-MMM-yyyy HH:mm:ss"
                createdAtLb.text = formatter2.string(from: date)
            }
        }
        
        titleLb.text = post.title
        authorNameLb.text = post.author?.username ?? "Unknown"
    }
    
    func authorAvatar(image: UIImage?) {
        if let uwImage = image {
            authorAvatarImageView.image = uwImage
        } else {
            /// Set avatar is image default
            authorAvatarImageView.image = UIImage(named: "user_default")
        }
    }
}
