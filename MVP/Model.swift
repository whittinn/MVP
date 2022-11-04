//
//  Model.swift
//  MVP
//
//  Created by Nathaniel Whittington on 11/3/22.
//

import Foundation

struct Posts: Decodable{
    
    let userId:Int?
    let id:Int?
    let title: String?
    let body: String?
}
