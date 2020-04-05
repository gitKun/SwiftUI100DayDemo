//
//  UseTimerDemo.swift
//  Flashzilla_17
//
//  Created by DR_Kun on 2020/3/14.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct UseTimerDemo: View {
    //let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    /*
     * tolerance 允许的 iOS 系统给与的 容差时间,
     * 系统将自动根据需要推迟或提前次timer,
     * 为了和别的定时器一起触发,使 CPU 包吃更多的空闲以节省电量
    */
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { (time) in
                if self.counter == 5 {
                    // 取消 timer
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                self.counter += 1
        }
    }
}

struct UseTimerDemo_Previews: PreviewProvider {
    static var previews: some View {
        UseTimerDemo()
    }
}
