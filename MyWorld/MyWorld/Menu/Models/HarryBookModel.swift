//
//  HarryBookModel.swift
//  MyWorld
//
//  Created by pc on 14/05/2023.
//

import Foundation
import SwiftUI

// MARK: - HarryBookElement
struct HarryBook: Codable, Identifiable {
    var _id : UUID { return UUID() }
    var id : Int?
    var title: String
    var image_url: String
    var artists: [ArtistModel]
    var release_date: String
    
}

// MARK: - Artist
struct ArtistModel: Codable, Identifiable {
    var _id : UUID { return UUID() }
    var id : Int?
    var author: AuthorModel
}

// MARK: - Author
struct AuthorModel: Codable, Identifiable {
    var _id : UUID { return UUID() }
    var id : Int?
    var name: String
}



// MARK: - HarryBookDetailModel
struct HarryBookDetailModel: Codable, Identifiable {
    var _id : UUID { return UUID() }
    var id : Int?
    var title: String
    var image_url: String
    var book_artists: [BookArtistModel]
    var pages: Int
    var publisher, release_date, followed_by, updated_at: String
    var created_at: String
}

// MARK: - BookArtist
struct BookArtistModel: Codable, Identifiable {
    var _id : UUID { return UUID() }
    var id : Int?
    var name, role: String
}
