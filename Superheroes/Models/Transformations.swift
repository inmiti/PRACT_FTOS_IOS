//
//  Transformations.swift
//  Superheroes
//
//  Created by ibautista on 27/9/23.
//

import Foundation

struct Transformation: Decodable, Equatable {
    let id: String
    let name: String
    let description: String
    let photo: URL
}
