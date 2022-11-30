//
//  models.swift
//  Charity
//
//  Created by Al Stark on 16.11.2022.
//

import Foundation

struct answer {
    var UID: String
}

struct Charity {
    let creatorID: String
    let name: String
    let description: String
    let photoURL: String?
    let latitude: Float?
    let logitude: Float?
    let art: Bool
    let children: Bool
    let education: Bool
    let healthcare: Bool
    let poverty: Bool
    let scienceResearch: Bool
    let qiwiURL: String?
}

enum SignAnswer: Error {
    case emailExist
    case emailNotExist
    case unknownError
    case emailNotVerified
    case wrongPassword
}
