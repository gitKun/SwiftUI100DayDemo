//
//  UseOnRevceiveDemo.swift
//  Flashzilla_17
//
//  Created by DR_Kun on 2020/3/14.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct UseOnRevceiveDemo: View {
    /**
     * willResignActiveNotification 在用户离开您的应用程序时
     * willEnterForegroundNotification 当用户重新激活您的应用程序并且有机会继续进行任何重要工作时会调用
     * userDidTakeScreenshotNotification 检测用户何时拍摄了屏幕截图
     * significantTimeChangeNotification  当用户更改时钟或夏时制更改时，将调用。
     * keyboardDidShowNotification 显示键盘时调用。
     * 用于onReceive()捕获发布者的通知，然后采取所需的任何操作。
     */
    var body: some View {
        Text("Hello, World!")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background!")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            print("Moving back to the foreground!")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
            print("User took a screenshot!")
        }
    }
}

struct UseOnRevceiveDemo_Previews: PreviewProvider {
    static var previews: some View {
        UseOnRevceiveDemo()
    }
}
