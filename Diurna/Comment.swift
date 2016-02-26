//
//  Comment.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 24/01/2016.
//  Copyright © 2016 Nicolas Gaulard-Querol. All rights reserved.
//

import SwiftyJSON

class Comment: Item {
    let parent: String
    let deleted: Bool
    let kidsIds: [Int]
    var kids: [Comment]

    override init?(json: JSON) {
        self.parent = json["parent"].stringValue
        self.deleted = json["deleted"].boolValue
        self.kidsIds = json["kids"].arrayValue.map { $0.intValue }
        self.kids = []
        super.init(json: json)
    }
}
