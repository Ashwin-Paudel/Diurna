//
//  HNAPIConsumer.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 30/06/2020.
//  Copyright © 2020 Nicolas Gaulard-Querol. All rights reserved.
//

import HackerNewsAPI

protocol HNAPIConsumer {
    var apiClient: HNAPIClient { get }
}

extension HNAPIConsumer {
    var apiClient: HNAPIClient { MockHNAPIClient() }
}
