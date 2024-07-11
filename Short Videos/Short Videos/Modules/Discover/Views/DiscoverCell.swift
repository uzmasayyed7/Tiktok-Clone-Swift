//
//  DiscoverCell.swift
//  Short Videos
//
//  Created by Uzma  on 08/07/24.
//  Copyright © 2024 Kaishan. All rights reserved.
//

import UIKit

fileprivate let cellReuseId = "DiscoverCellcellReuseId"


protocol DiscoverCellDelegate: AnyObject {
    // Navigate to Profile Page
    func playVideo(urlString: String)
}

class DiscoverCell: UICollectionViewCell {
    //MARK: - Properties
    var item: DiscoverItem? {
        didSet {
            guard let item = item else { return }
            hashtagTitleLabel.text = item.hashtag
            trendingHashtagLabel.text = item.trending
            postCountLabel.text = item.postCount
            videos = item.videos
            collectionView.reloadData()
            if let url = URL(string: item.iconUrl) {
                hashtagImageView.load(url: url)
            }
        }
    }

    weak var delegate: DiscoverCellDelegate?
    
    fileprivate let hashtahImageViewDimention: CGFloat = 35
    fileprivate lazy var hashtagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = hashtahImageViewDimention / 2
        return imageView
    }()

    fileprivate let hashtagTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    fileprivate let trendingHashtagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.5)
        label.textColor = .gray
        return label
    }()
    
    fileprivate let postCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = .white
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .black
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    fileprivate let lineSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    fileprivate var videos: [Video] = []

    //MARK: - View LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        handleSetUpViews()
    }

    func handleSetUpViews() {
       
        [hashtagImageView, hashtagTitleLabel, trendingHashtagLabel, postCountLabel, collectionView, lineSeperatorView].forEach { (view) in
            addSubview(view)
        }
        
        hashtagImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: hashtahImageViewDimention, height: hashtahImageViewDimention))
        
        hashtagTitleLabel.anchor(top: hashtagImageView.topAnchor, leading: hashtagImageView.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 1, left: 5, bottom: 0, right: 0))
        
        trendingHashtagLabel.anchor(top: hashtagTitleLabel.bottomAnchor, leading: hashtagTitleLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2.5, left: 0, bottom: 0, right: 0))
        
        postCountLabel.anchor(top: hashtagTitleLabel.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 12), size: .init(width: 70, height: 20))
        
        collectionView.anchor(top: trendingHashtagLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 15, right: 0))
        collectionView.register(DiscoverImageCell.self, forCellWithReuseIdentifier: cellReuseId)
        
        lineSeperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 0.4))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - CollectionView Delegates
extension DiscoverCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as! DiscoverImageCell
        let imageUrl = videos[indexPath.item].thumbnailUrl
        cell.configure(with: imageUrl)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 3.5
        return .init(width: width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.playVideo(urlString: videos[indexPath.item].videoUrl)
    }
}

class DiscoverImageCell: UICollectionViewCell {
    //MARK: - Properties
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    //MARK: - View LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with imageUrl: String) {
        // Here, you would load the image from the URL.
        // For example, using SDWebImage or another image loading library.
        // For simplicity, let's assume you have a method to load images.
        loadImage(from: imageUrl)
        
    }

    private func loadImage(from imageUrl: String) {
        // Implement the image loading logic here.
        // For example, using SDWebImage:
        if let url = URL(string: imageUrl) {
            imageView.load(url: url)
        }
        
        // For now, let's just set a placeholder color.
        imageView.backgroundColor = .gray
    }
}
