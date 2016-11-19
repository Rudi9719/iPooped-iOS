//
//  Poop.swift
//  iPooped
//
//  Created by Gregory Rudolph-Alverson on 10/26/16.
//  Copyright © 2016 STEiN-Net. All rights reserved.
//

import Foundation
import CloudKit
import MapKit
import UIKit


class Poop: NSObject, NSCoding {
    
    // MARK: Properties
    
    // MARK: Types
    struct PropertyKey {
        static let datetimeKey = "datetime"
        static let latKey = "latitude"
        static let longKey = "longitude"
        static let rateKey = "rate"
        static let notesKey = "notes"
        static let picKey = "picture"
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("shits")
    
    
    var datetime: String
    var location: CLLocationCoordinate2D
    var rate: Int
    var notes: String?
    var pic: UIImage?
    
    let locationManager = CLLocationManager()
    let date = Date()
    let calendar = Calendar.current
    let pickerData = ["Awesome", "Good", "Okay", "Average", "Eh", "Meh",
                      "Shitty", "Wtf", "Oh shit", "Call 911"]
    
    
    
    init(loc: CLLocationCoordinate2D, rating: Int, note: String?, picture: UIImage?) {
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        
        datetime = "\(month)/\(day)/\(year) @ \(hour):\(minute)"
        rate = rating
        location = loc
        if note != nil {
            notes = note
        }
        if picture != nil {
            pic = picture
        }
    }

    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(location.latitude, forKey: PropertyKey.latKey)
        aCoder.encode(location.longitude, forKey: PropertyKey.longKey)
        aCoder.encode(rate, forKey: PropertyKey.rateKey)
        aCoder.encode(datetime, forKey: PropertyKey.datetimeKey)
        aCoder.encode(notes, forKey: PropertyKey.notesKey)
        aCoder.encode(pic, forKey: PropertyKey.picKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        datetime = aDecoder.decodeObject(forKey: PropertyKey.datetimeKey) as! String
        notes = aDecoder.decodeObject(forKey: PropertyKey.notesKey) as? String
        rate = aDecoder.decodeInteger(forKey: PropertyKey.rateKey)
        let lat = aDecoder.decodeDouble(forKey: PropertyKey.latKey) 
        let long = aDecoder.decodeDouble(forKey: PropertyKey.longKey) 
        location = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        pic = aDecoder.decodeObject(forKey: PropertyKey.picKey) as? UIImage
        super.init()
    }
    
}
