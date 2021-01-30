//
//  JSONModel.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import Foundation

struct JSONModel: Decodable {
    let data: [DataArray]
    let view: [String]
}

struct DataArray: Decodable {
    let name: String
    let data: DataInformation
}

struct DataInformation: Decodable {
    let url: String?
    let text: String?
    let selectedId: Int?
    let variants: [Variants]?
}

struct Variants: Decodable {
    let id: Int
    let text: String
}
