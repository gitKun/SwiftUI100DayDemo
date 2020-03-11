//
//  ImagePicker.swift
//  Instafilter
//
//  Created by DR_Kun on 2020/3/11.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    typealias UIViewControllerType = UIImagePickerController // 生成 UIViewControllerRepresentable 方法后可删除
    
    // 数据处理类->协调器
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    // UIViewControllerRepresentable 的协议方法
    func makeCoordinator() -> Coordinator{
        return Coordinator(self)
    }
    
    // UIViewControllerRepresentable 的协议方法
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    // UIViewControllerRepresentable 的协议方法
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}

