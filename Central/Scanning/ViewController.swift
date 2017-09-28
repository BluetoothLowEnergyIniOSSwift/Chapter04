//
//  ViewController.swift
//  Bootstrapping
//
//  Created by Adonis Gaitatzis on 11/15/16.
//  Copyright © 2016 Adonis Gaitatzis. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate {
    
    var bluetoothOn = false
    var centralManager:CBCentralManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startUpCentralManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///
    ///
    func startUpCentralManager() {
        print("Initializing central manager")
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    func discoverDevices() {
        print ("discovering devices")
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    
    /** CBCentralManagerDelegate Functions **/
    
    /// centralManager is called each time a new Peripheral is discovered
    ///
    /// - parameters
    ///   - central: the CentralManager for this UIView
    ///   - peripheral: A discovered Peripheral
    ///   - advertisementData: The Bluetooth advertisement data discevered with the Peripheral
    ///   - rssi: the radio signal strength indicator for this Peripheral
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name)")
    }
    
    
    
    /// centralManagerDidUpdateState is called when the Bluetooth Radio state is changed
    ///
    /// - parameters
    ///   - central: the CentralManager for this UIView
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central Manager updated: checking state")
        
        switch (central.state) {
        case .poweredOff:
            print ("BLE Hardware is powered off")
        case .poweredOn:
            print ("BLE Hardware powered on and ready")
        case .resetting:
            print ("BLE Hardware is resetting...")
        case .unauthorized:
            print ("BLE State is unauthorized")
        case .unsupported:
            print ("Ble hardware is unsupported on this device")
        case .unknown:
            print ("Ble state is unavailable")
        }
        if (bluetoothOn) {
            discoverDevices()
        }
    }
    
}

