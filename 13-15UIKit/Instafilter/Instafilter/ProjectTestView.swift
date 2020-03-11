//
//  ProjectTestView.swift
//  Instafilter
//
//  Created by DR_Kun on 2020/3/11.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ProjectTestView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProjectTestView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectTestView()
    }
}


struct UseUIImagePickerDemo1: View {
    
    @State private var showingImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Button("Select image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

/// CoreImage 的简单使用
struct CoreImageDemo1: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    func loadImage() {
        guard let inputImage = UIImage(named: "imageRoot") else { return }
        let begainImage = CIImage(image: inputImage) // 类型: CIImage?
        
        let context = CIContext()
        #if false
        // 棕色滤镜
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = begainImage
        currentFilter.intensity = 1
        
        #elseif false
        // 像素化滤镜
        let currentFilter = CIFilter.pixellate()
        currentFilter.inputImage = begainImage
        currentFilter.scale = 100
        
        #elseif true
        // 水晶效果
        let currentFilter = CIFilter.crystallize()
        // 存在BUG,不能像 像素一样直接设置 inputImage 需要使用 setValue
        // currentFilter.inputImage = begainImage
        currentFilter.setValue(begainImage, forKey: kCIInputImageKey)
        currentFilter.radius = 20
        
        #elseif false
        // 旋转扭曲效果
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(begainImage, forKey: kCIInputImageKey)
        currentFilter.setValue(300, forKey: kCIInputRadiusKey)
        //  CIVector: Core Image存储点和方向的方法。
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        #endif
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
}

/// ActionSheet
struct ActionSheetDemo: View {
    
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(
                title: Text("Change background"),
                message: Text("Select a new color"),
                buttons: [
                    .default(Text("Red")) { self.backgroundColor = .red },
                    .default(Text("Green")) { self.backgroundColor = .green },
                    .default(Text("Blue")) { self.backgroundColor = .blue }
                ]
            )
        }
    }
}

/// @propertyWrapper 探究
struct BindingTest1: View {
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            /*
             * 1. 直接使用 $, 将其传入 Slider 是不会调用 didSet 的,
             *  这是因为 @State 将 blurAmount 包裹成一个结构体,
             *   $ 传入 Slider 的值是包裹后的值 详见 cmd + Shift + O 后搜索 State 查看
             * 2. 如果代码里面直接调用 self.blurAmount 将会调用此代码
             */
            print("这里永远不会执行!")
        }
    }
    
    var body: some View {
        // 使用 Binding 来处理
        let blur = Binding<CGFloat>(
            get: {
                return self.blurAmount
        },
            set: {
                print("这里会正确的打印信息!")
                self.blurAmount = $0
        }
        )
        
        return VStack {
            Text("Hello, World!")
                .blur(radius: self.blurAmount)
            //Slider(value: $blurAmount, in: 0...2).padding()
            Slider(value: blur, in: 0...2).padding()
        }
    }
}
