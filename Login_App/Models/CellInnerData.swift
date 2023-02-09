//
//  CellInnerData.swift
//  Login_App
//
//  Created by Henadzi on 05/12/2022.
//

import UIKit

enum HomeInnerVCType {
    case longread(_ text: String)
    case color(_ color: UIColor)
    case image(_ image: UIImage?)
}

protocol HomeInnerVCProtocol {
    var type: HomeInnerVCType { get }
    var title: String { get }
}

struct ImageData: HomeInnerVCProtocol {
    let id: String = UUID().uuidString
    var type: HomeInnerVCType
    var title: String
}

struct LongreadData: HomeInnerVCProtocol {
    let id: String = UUID().uuidString
    var type: HomeInnerVCType
    var title: String
}

struct ColorData: HomeInnerVCProtocol {
    let id: String = UUID().uuidString
    var type: HomeInnerVCType
    var title: String
}
