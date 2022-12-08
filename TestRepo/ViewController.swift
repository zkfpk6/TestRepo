//
//  ViewController.swift
//  TestRepo
//
//  Created by 张楷枫 on 2022/12/8.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    // MARK: - lazy load
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: self.collectionViewLayout)
        collectionView.backgroundColor = .gray
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
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

        Observable.just(Array(repeating: UIColor.red, count: 10))
            .bind(to: collectionView.rx.items) { collectionView, row, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: IndexPath(row: row, section: 0))
                cell.backgroundColor = item
                return cell
            }
            .disposed(by: disposeBag)
        collectionView.rx.contentOffset.bind { _ in }
            .disposed(by: disposeBag)
    }

    private var disposeBag = DisposeBag()
    private func configUI() {
        view.addSubview(collectionView)
    }


}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate { }

extension RxCollectionViewDelegateProxy: CollectionViewWaterfallLayoutDelegate {
    public func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
