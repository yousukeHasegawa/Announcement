//
//  WebMessage.swift
//  Announcement
//
//  Created by Yousuke Hasegawa on 2021/12/13.
//

import Foundation

struct WebMessage : Codable {
    let id: Int?
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
    }
}
