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
    func configCell(_ model: DataSoure) {
        avatarImage.image = UIImage(named: model.image)
        myLabel.text = model.title1
        mytitleLabel.text = model.title2
        myButton.setTitle(model.button, for: .normal)
        myButton.layer.borderColor = UIColor.systemBlue.cgColor
        myButton.layer.borderWidth = 1
        myButton.tintColor = .systemBlue
        myButton.layer.cornerRadius = 10
    }
    
    @IBAction func clickNext(_ sender: Any) {
        didTapSkip?()
    }
    
}
