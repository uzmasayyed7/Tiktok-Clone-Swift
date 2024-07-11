//
//  DiscoverHeader.swift
//  Short Videos
//
//  Created by Uzma  on 08/07/24.
//  Copyright © 2024 Kaishan. All rights reserved.
//

import UIKit

fileprivate let cellReuseId = "DiscoverHeadercellReuseId"

class DiscoverHeader: UICollectionViewCell {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUpViews()
        startAutoScroll()
    }
    
    var imageUrls: [String] = [] {
        didSet {
            pageControl.numberOfPages = imageUrls.count
            collectionView.reloadData()
        }
    }
    
    fileprivate var timer: Timer?

    //MARK: - Properties
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = imageUrls.count
        pc.clipsToBounds = true
        pc.layer.masksToBounds = true
        return pc
    }()
    
    //MARK: - Handlers
    fileprivate func setUpViews() {
        addSubview(collectionView)
        addSubview(pageControl)
        collectionView.fillSuperview()
        collectionView.register(DiscoverHeaderCell.self, forCellWithReuseIdentifier: cellReuseId)
        
        pageControl.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20), size: .init(width: 0, height: 25))
    }

    fileprivate func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func scrollToNextItem() {
        let visibleItems = collectionView.indexPathsForVisibleItems
        let currentItem = visibleItems.first
        let nextItem: IndexPath
        
        if let currentItem = currentItem, currentItem.item < imageUrls.count - 1 {
            nextItem = IndexPath(item: currentItem.item + 1, section: currentItem.section)
        } else {
            nextItem = IndexPath(item: 0, section: 0)
        }
        
        collectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = nextItem.item
    }
    
    deinit {
        stopAutoScroll()
    }

    //MARK: - Code Was Created by SamiSays11. Copyright © 2019 SamiSays11 All rights reserved.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - CollectionView Delegates
extension DiscoverHeader: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as! DiscoverHeaderCell
        cell.configure(with: imageUrls[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / frame.width)
        pageControl.currentPage = pageNumber
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

