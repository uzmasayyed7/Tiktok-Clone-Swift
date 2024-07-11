//
//  DiscoverItem.swift
//  Short Videos
//
//  Created by Uzma  on 08/07/24.
//  Copyright © 2024 Kaishan. All rights reserved.
//

import Foundation

struct DiscoverItem {
    let iconUrl: String
    let hashtag: String
    let trending: String
    let postCount: String
    let videos: [Video]
}

struct Video {
    let thumbnailUrl : String
    let videoUrl: String
}

