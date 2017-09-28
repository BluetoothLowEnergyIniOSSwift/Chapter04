//
//  BlePeripheral.swift
//  sketch
//
//  Created by Adonis Gaitatzis on 1/9/17.
//  Copyright © 2017 Adonis Gaitatzis. All rights reserved.
//

import UIKit
import CoreBluetooth


class BlePeripheral : NSObject, CBPeripheralManagerDelegate {
    
    
    // MARK: Peripheral properties
    
    // Advertized name
    let advertisingName = "MyDevice"
    
    // Device identifier
    let peripheralIdentifier = "8f68d89b-448c-4b14-aa9a-f8de6d8a4753"
    
    // MARK: Peripheral State
    
    // Peripheral Manager
    var peripheralManager:CBPeripheralManager!
    
    // Connected Central
    var central:CBCentral!
    
    // delegate
    var delegate:BlePeripheralDelegate!
    
    /**
     Initialize BlePeripheral with a corresponding Peripheral
     
     - Parameters:
     - delegate: The BlePeripheralDelegate
     - peripheral: The discovered Peripheral
     */
    init(delegate: BlePeripheralDelegate?) {
        super.init()
        
        // empty dispatch queue
        let dispatchQueue:DispatchQueue! = nil
        
        // Build Advertising options
        let options:[String : Any] = [
            //
            CBPeripheralManagerOptionShowPowerAlertKey: true,
            // Peripheral unique identifier
            CBPeripheralManagerOptionRestoreIdentifierKey: peripheralIdentifier
        ]
        self.delegate = delegate
        peripheralManager = CBPeripheralManager(delegate: self, queue: dispatchQueue, options: options)
    }

    /**
     Stop advertising, shut down the Peripheral
     */
    func stop() {
        peripheralManager.stopAdvertising()        
    }
    
    /**
     Start Bluetooth Advertising. 
     */
    func startAdvertising() {
        let advertisementData:[String: Any] = [
            CBAdvertisementDataLocalNameKey: advertisingName
        ]
        
        peripheralManager.startAdvertising(advertisementData)
    }
    
    // MARK: CBPeripheralManagerDelegate
    
    /**
     Peripheral started advertising
     */
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error != nil {
            print ("Error advertising peripheral")
            print(error.debugDescription)
        }
        self.peripheralManager = peripheral
        
        delegate?.blePerihperal?(startedAdvertising: error)
    }
    
    /**
     Peripheral will become active
     */
    func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
        print("restoring peripheral state")
    }
    
    /**
     Bluetooth Radio state changed
     */
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        peripheralManager = peripheral
        switch peripheral.state {
        case CBManagerState.poweredOn:
            startAdvertising()
        default: break
        }
        delegate?.blePeripheral?(stateChanged: peripheral.state)
        
    }
}
