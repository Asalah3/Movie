//
//  Movie.swift
//  MovieApp
//
//  Created by Asalah Sayed on 02/05/2023.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let items: [Item]
    let errorMessage: String
}

// MARK: - Item
struct Item: Codable {
    let id, rank, title: String
    let image: String
    let weekend, gross, weeks: String
}
