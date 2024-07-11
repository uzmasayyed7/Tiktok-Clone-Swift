//
//  User.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 9/20/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import Foundation
import UIKit

struct User {
    var uid: String
    var name: String
    var description: String
    var douyinID: Int
    var tags: [String]
    var profilePic: String
    var posts: [String]
    var likedPosts: [String]
    var followerCount: Int
    var followCount: Int
    var likeCount: Int
    var friendsCount: Int
}
