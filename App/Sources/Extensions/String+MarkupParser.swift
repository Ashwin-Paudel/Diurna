//
//  String+MarkupParser.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 18/02/2016.
//  Copyright © 2016 Nicolas Gaulard-Querol. All rights reserved.
//

import Foundation

extension String {
    func parseMarkup() -> NSAttributedString {
        var parser = MarkupParser(input: self)
        return parser.toAttributedString()
    }
}
