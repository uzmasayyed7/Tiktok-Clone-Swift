//
//  ProfileSlideBarView.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 9/14/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import UIKit
import SnapKit

class ProfileSlideBarView: UICollectionReusableView {
    
    // MARK: - UI Components
    var videosLbl: UILabel!
    var feedLbl: UILabel!
    var likeLbl: UILabel!
    var bottomSlidingLine: CALayer!
    
    // MARK: - Variables
    enum Section {
        case videos, feed, likes
    }
    var currentSection: Section = .videos
    var sectionSelected: ((Section) -> Void)?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set up
    func setupView() {
        self.backgroundColor = .black
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchSection(sender:)))
        self.addGestureRecognizer(tapGesture)
        
        // Video Label
        videosLbl = SlideBarLabel()
        videosLbl.text = "Videos"
        addSubview(videosLbl)
        videosLbl.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.left.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        // Feed Label
        feedLbl = SlideBarLabel()
        feedLbl.text = "Feed"
        addSubview(feedLbl)
        feedLbl.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        // Like Label
        likeLbl = SlideBarLabel()
        likeLbl.text = "Likes"
        addSubview(likeLbl)
        likeLbl.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        bottomSlidingLine = CALayer()
        bottomSlidingLine.backgroundColor = UIColor.yellow.cgColor
        bottomSlidingLine.frame = CGRect(x: 0, y: self.frame.size.height - 3, width: self.frame.size.width / 3, height: 3)
        self.layer.addSublayer(bottomSlidingLine)
    }
    
    //MARK: - Actions
    @objc func switchSection(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        if videosLbl.frame.contains(location) && currentSection != .videos {
            currentSection = .videos
        } else if feedLbl.frame.contains(location) && currentSection != .feed {
            currentSection = .feed
        } else if likeLbl.frame.contains(location) && currentSection != .likes {
            currentSection = .likes
        }
        sectionSelected?(currentSection)
        slideTo(section: currentSection)
    }
    
    func slideTo(section: Section) {
        switch section {
        case .videos:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.allowUserInteraction, .curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.bottomSlidingLine.frame = CGRect(x: 0, y: self.frame.size.height - 3, width: self.frame.size.width / 3, height: 3)
            }, completion: nil)
        case .feed:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.allowUserInteraction, .curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.bottomSlidingLine.frame = CGRect(x: self.frame.size.width / 3, y: self.frame.size.height - 3, width: self.frame.size.width / 3, height: 3)
            }, completion: nil)
        case .likes:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, options: [.allowUserInteraction, .curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.bottomSlidingLine.frame = CGRect(x: self.frame.size.width / 3 * 2, y: self.frame.size.height - 3, width: self.frame.size.width / 3, height: 3)
            }, completion: nil)
        }
    }
}

class SlideBarLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        textAlignment = .center
        backgroundColor = .clear
        font = UIFont.systemFont(ofSize: 17, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
