//
//  ColorPickerView.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/2/29.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct ColorPickerView: View {
    var body: some View {
        ColorPickerContentView()
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}


/// enum 管理颜色类型
fileprivate enum PickedColor: CaseIterable {
    case black, blue, green, orange, red, yellow, purple
    
    var color: Color {
        return Color(uiColor)
    }
    
    var uiColor: UIColor {
        switch self {
        case .black: return UIColor.black
        case .blue: return UIColor.blue
        case .green: return UIColor.green
        case .orange: return UIColor.orange
        case .red: return UIColor.red
        case .yellow: return UIColor.yellow
        case .purple: return UIColor.purple
        }
    }
}

/// 颜色选择效果
fileprivate struct ColorPicker: View {
    @Binding var pickedColor: PickedColor
    let diameter: CGFloat = 40
    
    var body: some View {
        HStack {
            ForEach(PickedColor.allCases, id: \.self) { pickerColor in
                ZStack {
                    Circle()
                        .foregroundColor(pickerColor.color)
                        .frame(width: self.diameter, height: self.diameter)
                        .onTapGesture {
                            self.pickedColor = pickerColor
                            print("\(PickedColor.allCases.firstIndex(of: pickerColor)!)")
                    }
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: self.pickedColor == pickerColor ? self.diameter * 0.25 : 0)
                }
            }
        }
        .frame(height: diameter * 3)
    }
}

/// 照片选择效果
fileprivate struct ColorPickerContentView: View {
    @State var pickedColor: PickedColor = .red
    var body: some View {
        VStack {
            Image("touxiang_\(PickedColor.allCases.firstIndex(of: pickedColor)!+1)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:250,height: 250)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(lineWidth:8)
                        .foregroundColor(pickedColor.color)
            )
            ColorPicker(pickedColor: $pickedColor)
        }
    }
}
