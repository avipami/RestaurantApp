//
//  FilterTypes.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-20.
//

import Foundation

struct FilterTags {
    
    
    func tagMapper(tagfor: FilterType) -> String {
        return tagfor.rawValue
    }
}
enum FilterType: String {
    case TakeOut
}
