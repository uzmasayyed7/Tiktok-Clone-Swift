//
//  Post.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed on 9/8/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct Post: Codable{
    var id: String
    var video: String
    var videoURL: URL?
    var videoFileExtension: String?
    var videoHeight: Int
    var videoWidth: Int
    var autherID: String
    var autherName: String
    var caption: String
    var music: String
    var likeCount: Int
    var shareCount: Int
    var commentID: String
    var thumbnailURL: String
    var title: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case video
        case videoURL
        case videoFileExtension
        case videoHeight
        case videoWidth
        case autherID = "author"
        case autherName
        case caption
        case music
        case likeCount
        case shareCount
        case commentID
        case thumbnailURL
        case title
    }
    
    init(id: String, video: String, videoURL: URL? = nil, videoFileExtension: String? = nil, videoHeight: Int, videoWidth: Int, autherID: String, autherName: String, caption: String, music: String, likeCount: Int, shareCount: Int, commentID: String, thumbnailURL: String, title: String) {
        self.id = id
        self.video = video
        self.videoURL = videoURL ?? URL(fileURLWithPath: "")
        self.videoFileExtension = videoFileExtension ?? "mp4"
        self.videoHeight = videoHeight
        self.videoWidth = videoWidth
        self.autherID = autherID
        self.autherName = autherName
        self.caption = caption
        self.music = music
        self.likeCount = likeCount
        self.shareCount = shareCount
        self.commentID = commentID
        self.thumbnailURL = thumbnailURL
        self.title = title
    }
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as? String ?? ""
        video = dictionary["video"] as? String ?? ""
        let urlString = dictionary["videoURL"] as? String ?? ""
        videoURL = URL(string: urlString)
        videoFileExtension = dictionary["videoFileExtension"] as? String ?? ""
        videoHeight = dictionary["videoHeight"] as? Int ?? 0
        videoWidth = dictionary["videoWidth"] as? Int ?? 0
        autherID = dictionary["author"] as? String ?? ""
        autherName = dictionary["autherName"] as? String ?? ""
        caption = dictionary["caption"] as? String ?? ""
        music = dictionary["music"] as? String ?? ""
        likeCount = dictionary["likeCount"] as? Int ?? 0
        shareCount = dictionary["shareCount"] as? Int ?? 0
        commentID = dictionary["commentID"] as? String ?? ""
        thumbnailURL = dictionary["thumbnailURL"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
    }

    
    var dictionary: [String: Any] {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return (try? JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .allowFragments]) as? [String: Any]) ?? [:]
    }
}

let samplePosts = [
    Post(dictionary: [
        "id": "1",
        "autherName": "User1",
        "autherID": "user1id",
        "videoURL": "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4",
        "videoFileExtension": "mp4",
        "videoWidth": 1080,
        "videoHeight": 1920,
        "thumbnailURL": "https://images.unsplash.com/photo-1593642634367-d91a135587b5",
        "title": "Sample Video 1"
    ]),
    Post(dictionary: [
        "id": "2",
        "autherName": "User2",
        "autherID": "user2id",
        "videoURL": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
        "videoFileExtension": "mp4",
        "videoWidth": 1080,
        "videoHeight": 1920,
        "thumbnailURL": "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
        "title": "Sample Video 2"
    ]),
    Post(dictionary: [
        "id": "3",
        "autherName": "User3",
        "autherID": "user3id",
        "videoURL": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        "videoFileExtension": "mp4",
        "videoWidth": 1080,
        "videoHeight": 1920,
        "thumbnailURL": "https://images.unsplash.com/photo-1511367461989-f85a21fda167",
        "title": "Sample Video 3"
    ]),
    Post(dictionary: [
        "id": "4",
        "autherName": "User4",
        "autherID": "user4id",
        "videoURL": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
        "videoFileExtension": "mp4",
        "videoWidth": 1080,
        "videoHeight": 1920,
        "thumbnailURL": "https://images.unsplash.com/photo-1517430816045-df4b7de8cd6c",
        "title": "Sample Video 4"
    ]),
    Post(dictionary: [
        "id": "5",
        "autherName": "User5",
        "autherID": "user5id",
        "videoURL": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
        "videoFileExtension": "mp4",
        "videoWidth": 1080,
        "videoHeight": 1920,
        "thumbnailURL": "https://images.unsplash.com/photo-1498050108023-c5249f4df085",
        "title": "Sample Video 5"
    ])
]
