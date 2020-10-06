//
//  TestModel.swift
//  TestApp
//
//  Created by BEREZIN Stanislav on 06.10.2020.
//

import Foundation

struct TestModel: Codable {
    let data: [TestData]?
    let view: [String]?
}

struct TestData: Codable {
    let name: String?
    let data: Detail?
}

struct Detail: Codable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Variant]?
}

struct Variant: Codable {
    let id: Int?
    let text: String?
}
