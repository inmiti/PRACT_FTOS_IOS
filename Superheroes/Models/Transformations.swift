//
//  Transformations.swift
//  Superheroes
//
//  Created by ibautista on 27/9/23.
//

import Foundation

struct Transformation: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let hero: Hero
    
}
