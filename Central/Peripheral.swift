//
//  Peripheral.swift
//  Scanning
//
//  Created by Adonis Gaitatzis on 11/15/16.
//  Copyright © 2016 Adonis Gaitatzis. All rights reserved.
//

import UIKit

class Peripheral {
    var broadcastName: String!
    var macAddress: String!
    var rssi: Int!
    
    
    init(broadcastName: String, macAddress: String, rssi: Int) {
        self.broadcastName = broadcastName
        self.macAddress = macAddress
        self.rssi = rssi
    }
}
