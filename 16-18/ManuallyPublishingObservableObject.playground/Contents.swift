import SwiftUI
import PlaygroundSupport


class DelayedUpdater: ObservableObject {
    //@Published var value = 0 // 自动更改使用 @Published
    
    // 手动处理通知的发送
    var value = 0 {
        willSet {
            // 这里做我们需要处理的其他事物
            print("\(newValue)")
            // 这里手动调用 objectWillChange 发送通知
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is: \(updater.value)")
    }
}


PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())

