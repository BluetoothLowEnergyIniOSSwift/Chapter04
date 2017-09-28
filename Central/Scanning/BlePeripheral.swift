//
//  BlePeripheral.swift
//  Scanning
//
//  Created by Adonis Gaitatzis on 12/12/16.
//  Copyright © 2016 Adonis Gaitatzis. All rights reserved.
//

import UIKit
import CoreBluetooth


/**
 BlePeripheral Handles communication with a Bluetooth Low Energy Peripheral
 */
class BlePeripheral: NSObject {
    
    // MARK: Peripheral properties
    
    // connected Peripheral
    var peripheral:CBPeripheral!
    
    // advertised name
    var advertisedName:String!
    
    // RSSI
    var rssi:NSNumber!
    
    /**
     Initialize BlePeripheral with a corresponding Peripheral
     
     - Parameters:
     - delegate: The BlePeripheralDelegate
     - peripheral: The discovered Peripheral
     */
    init(peripheral: CBPeripheral) {
        super.init()
        self.peripheral = peripheral
    }
    
    
    /**
     Get a broadcast name from an advertisementData packet.  This may be different than the actual broadcast name
     */
    static func getAlternateBroadcastFromAdvertisementData(advertisementData: [String : Any]) -> String? {
        // grab thekCBAdvDataLocalName from the advertisementData to see if there's an alternate broadcast name
        if advertisementData["kCBAdvDataLocalName"] != nil {
            return (advertisementData["kCBAdvDataLocalName"] as! String)
        }
        return nil
    }

}
