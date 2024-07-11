//
//  NetworkModel.swift
//  Tiktok-Clone-Swift
//
//  Created by Uzma Sayyed 9/20/20.
//  Copyright © 2020 Uzma Sayyed. All rights reserved.
//

import Foundation

class NetworkModel: NSObject {
    /// Firebase call successfully returns data
    typealias Success = (Any) -> Void
    /// Firebase call fails to return data
    typealias Failure = (Error) -> Void
}
