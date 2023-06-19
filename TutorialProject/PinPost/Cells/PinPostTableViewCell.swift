//
//  PinPostTableViewCell.swift
//  PostsApp
//
//  Created by Hà Văn Đức on 25/05/2023.
//

import UIKit

class PinPostTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func bindData(post: PostGetEntity) {
        contentLb.text = post.content
    }
}
