//
//  Feature.swift
//  AppStore
//
//  Created by 소현 on 1/3/24.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
