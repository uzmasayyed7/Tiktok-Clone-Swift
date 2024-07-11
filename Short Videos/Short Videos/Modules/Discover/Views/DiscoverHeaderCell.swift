//
//  DiscoverHeaderCell.swift
//  Short Videos
//
//  Created by Uzma  on 08/07/24.
//  Copyright © 2024 Kaishan. All rights reserved.
//

import UIKit

class DiscoverHeaderCell: UICollectionViewCell {
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
        // imageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        // For now, let's just set a placeholder color.
        if let url = URL(string: imageUrl) {
            imageView.load(url: url)
        }
        imageView.backgroundColor = .gray
    }
}
