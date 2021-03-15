//
//  Model.swift
//  TestAppMockiApi
//
//  Created by shizo663 on 15.03.2021.
//

import Foundation

struct FeedModel: Codable {
    let content: [Content]?
}

// MARK: - Content
struct Content: Codable {
    let texts: [String]?
    let sectionTitle: String?
    let images: [String]?
}
