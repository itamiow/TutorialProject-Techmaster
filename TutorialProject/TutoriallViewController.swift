//
//  TutoriallViewController.swift
//  UICollectionView
//
//  Created by USER on 31/05/2023.
//

import UIKit

struct DataSoure {
    let image: String
    let title1: String
    let title2: String
    let button: String
}
class TutoriallViewController: UIViewController{
    
    @IBOutlet weak private var myCollectionView: UICollectionView!
    
    
    
    let models: [DataSoure] = [DataSoure(image: "welcome", title1: "Welcom to Potugar", title2: "Hãy đến nơi đây", button: "Skip"),
                               DataSoure(image: "16", title1: "Chiến thôi nào", title2: "Cố lên", button: "Skip"),
                               DataSoure(image: "Porto", title1: "Đầu tiên hãy đến Porto", title2: "Đi thôi", button: "Start"),
    ]
    
//    var heightItemCell: CGFloat {
//        var bottomPadding: CGFloat = 0
//        if #available(iOS 11.0, *) {
//            let window = UIApplication.shared.keyWindow
//            bottomPadding = window?.safeAreaInsets.bottom ?? 0
//        }
//        let height = UIScreen.main.bounds.height - bottomPadding
//        return height
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupCollection() {
        myCollectionView.contentInsetAdjustmentBehavior = .never
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.isPagingEnabled = true // cuộn phân trang
        myCollectionView.bounces = false // cuộn không bị nẩy kích thước của Size
        myCollectionView.isScrollEnabled = true // khoá chế độ cuộn
        myCollectionView.showsVerticalScrollIndicator = false // giá trị false sẽ tắt hiển thị thanh indicator, thanh chiều dọc
        myCollectionView.showsHorizontalScrollIndicator = false // giá trị false sẽ tắt hiển thị thanh indicator, thanh chiều ngang
        myCollectionView.register(UINib(nibName: "ItemSection1CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemSection1CollectionViewCell")

        if let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing  = 0 // khoảng cách các dòng theo chiều dọc, trục y
            flowLayout.minimumInteritemSpacing = 0 // khoảng cách các dòng theo chiều ngang, trục x
            flowLayout.scrollDirection = .horizontal // chuyển cuộn trang ngang, dọc
            flowLayout.estimatedItemSize = .zero
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: heightItemCell)
            //chỉnh sửa kích thước ảnh
        }
        
        myCollectionView.reloadData()
    }
    
  
}
extension TutoriallViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    /**
     mặc định sẽ là 1
     định nghĩa số section trong 1 collectionview
     */
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return 1  /// section 0, 1, 2
    ///
    ///  định nghĩa trong 1 section
    //    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lisItem = models[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSection1CollectionViewCell", for: indexPath) as! ItemSection1CollectionViewCell
        cell.configCell(lisItem)
        cell.didTapSkip = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if indexPath.row == self.models.count - 1 {
                    
                    UserDefaultService.shared.completedTutorial = true

                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tutorialVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                    guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
                    let nv = UINavigationController(rootViewController: tutorialVC)
                    nv.setNavigationBarHidden(true, animated: true)
                    window.rootViewController = nv
                    window.makeKeyAndVisible()
                }
                self.scrollToNextCell()
            }
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    }
    func scrollToNextCell() {
        //lấy kích thước cell
        let cellSize = CGSizeMake(self.view.frame.width, self.view.frame.height);
//        let cellSize = CGSizeMake(self.view.frame.width, heightItemCell);
        //get current content Offset of the Collection view
        let contentOffset = myCollectionView.contentOffset
        
        //scroll to next cell
        myCollectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true);
    }
}

