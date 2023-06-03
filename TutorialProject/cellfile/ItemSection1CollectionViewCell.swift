//
//  ItemSection1CollectionViewCell.swift
//  UICollectionView
//
//  Created by USER on 31/05/2023.
//

import UIKit

class ItemSection1CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var backgroudTestView: UIView!
    @IBOutlet weak var mytitleLabel: UILabel!
    
    
    @IBOutlet weak var myButton: UIButton!
    var didTapSkip: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func clickNext(_ sender: Any) {
        didTapSkip?()
    }
    
}
