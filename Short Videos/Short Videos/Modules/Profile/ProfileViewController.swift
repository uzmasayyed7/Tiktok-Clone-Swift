//
//  ProfileViewController.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 9/8/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import UIKit
import RxSwift
import AVFoundation
import AVKit

class ProfileViewController: UIViewController {

    // MARK: - UI Components
    var collectionView: UICollectionView!
    var profileHeader: ProfileHeaderView?
    var profileBackgroundImgView: UIImageView!
    
    // MARK: - Variables
    let CELLID = "ProfileCell"
    let PROFILE_HEADER_ID = "ProfileHeader"
    let SLIDEBAR_ID = "ProfileSlideBar"
    
    let disposeBag = DisposeBag()
    var posts: [ProfilePost] = []
    var videos = sampleProfilePosts
    var feeds = sampleFeeds
    var likes = sampleLikes
    
    var currentSection: ProfileSlideBarView.Section = .videos {
        didSet {
            updateDataForCurrentSection()
        }
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        updateDataForCurrentSection()
    }
    
    // MARK: - Setup
    func setupView() {
        self.view.backgroundColor = .black
        
        // Profile Background Image view
        profileBackgroundImgView = UIImageView(image: UIImage(named: "ProfileBackground"))
        profileBackgroundImgView.translatesAutoresizingMaskIntoConstraints = false
        profileBackgroundImgView.contentMode = .scaleAspectFill
        profileBackgroundImgView.alpha = 0.6
        self.view.addSubview(profileBackgroundImgView)
        
        // Collection View
        let collectionViewLayout = ProfileCollectionViewFlowLayout(navBarHeight: getStatusBarHeight())
        collectionViewLayout.minimumLineSpacing = 1
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileBackgroundImgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        collectionView.register(UINib(nibName: "ProfileHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PROFILE_HEADER_ID)
        collectionView.register(ProfileSlideBarView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SLIDEBAR_ID)
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: CELLID)
    }
    
    func setupBindings() {
        // Any additional bindings can be added here
    }
    
    func updateDataForCurrentSection() {
        switch currentSection {
        case .videos:
            posts = videos
        case .feed:
            posts = feeds
        case .likes:
            posts = likes
        }
        collectionView.reloadData()
    }
}

// MARK: - Collection View Extension
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return posts.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELLID, for: indexPath) as! ProfileCollectionViewCell
        cell.configure(with: posts[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PROFILE_HEADER_ID, for: indexPath) as! ProfileHeaderView
                profileHeader = header
                return header
            }
        }
        
        if indexPath.section == 1 {
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SLIDEBAR_ID, for: indexPath) as! ProfileSlideBarView
                header.sectionSelected = { [weak self] section in
                    self?.currentSection = section
                }
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: view.frame.width, height: 420)
        case 1:
            return CGSize(width: view.frame.width, height: 42)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - CGFloat(Int(view.frame.width) % 3)) / 3.0 - 1.0
        let itemHeight = itemWidth * 1.3
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPost = posts[indexPath.item]
        playVideo(urlString: selectedPost.videoURL)
    }
    
    func playVideo(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            stretchProfileBackgroundWhenScroll(offsetY: offsetY)
        } else {
            profileBackgroundImgView.transform = CGAffineTransform(translationX: 0, y: -offsetY)
        }
    }
    
    func stretchProfileBackgroundWhenScroll(offsetY: CGFloat) {
        let scaleRatio: CGFloat = abs(offsetY) / 500.0
        let scaledHeight: CGFloat = scaleRatio * profileBackgroundImgView.frame.height
        profileBackgroundImgView.transform = CGAffineTransform(scaleX: scaleRatio + 1.0, y: scaleRatio + 1.0).concatenating(CGAffineTransform(translationX: 0, y: scaledHeight))
    }
}
