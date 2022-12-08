//
//  ViewController.swift
//  TestRepo
//
//  Created by 张楷枫 on 2022/12/8.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController : UIViewController {
    
    // MARK: - lazy load
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = .gray
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var collectionViewLayout = {
        let collectionViewLayout = CollectionViewWaterfallLayout()
        collectionViewLayout.columnCount = 2
        collectionViewLayout.minimumColumnSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        return collectionViewLayout
    }()
    

    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        // MARK: - crash
//        collectionView.rx.contentOffset.bind { _ in
//
//        }.disposed(by: disposeBag)
    }
    
    // MARK: - private
    var disposeBag = DisposeBag()
    func configUI() {
        view.addSubview(collectionView)
    }
    

}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewWaterfallLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}
