//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList_14
//
//  Created by DR_Kun on 2020/3/12.
//  Copyright © 2020 kun. All rights reserved.
//

import MapKit
import SwiftUI

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }
        set {
            subtitle = newValue
        }
    }
}

