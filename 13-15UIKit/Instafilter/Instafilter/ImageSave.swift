//
//  ImageSave.swift
//  Instafilter
//
//  Created by DR_Kun on 2020/3/11.
//  Copyright © 2020 kun. All rights reserved.
//

import UIKit


/// UnsafeRawPointer

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
