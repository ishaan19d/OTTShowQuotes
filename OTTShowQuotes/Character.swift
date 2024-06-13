//
//  Character.swift
//  OTTShowQuotes
//
//  Created by Ishaan Das on 13/06/24.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
    let death: Death?
}
