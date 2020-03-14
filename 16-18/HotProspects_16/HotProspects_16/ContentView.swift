//
//  ContentView.swift
//  HotProspects_16
//
//  Created by DR_Kun on 2020/3/12.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            
            ProspectView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            
            ProspectView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Conacted")
                }
            
            ProspectView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
            
        }
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// local notifications

import UserNotifications

struct LocalNotificationsDemo: View {
    var body: some View {
        VStack {
            // 请求权限
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding()
            
            // 添加通知
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "学习SwiftUI"
                content.subtitle = "请认真学习,不要走神,学习强国!"
                content.sound = UNNotificationSound.default
                
                // 从现在起五秒钟显示此通知
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                // 选择一个随机标识符
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                // 增加本地通知到通知中心
                UNUserNotificationCenter.current().add(request)
                
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .padding()
            
        }
    }
}


// 长按弹出 context mune
struct ContextMuneDemo: View {
    @State private var backgroundColor = Color.red
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)
            Text("Change Color") // 长按
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.red)
                        Spacer()
                        Text("Red")
                        Text("text")
                    }
                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                    }
                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                    }
            }
        }
    }
}


/**
 * 如果您创建一个SwiftUI Image视图以将其内容拉伸到大于其原始大小，会发生什么？
 * 默认情况下，我们获得图像插值，这是iOS如此平滑地混合像素的地方，
 * 您甚至可能根本没有意识到它们已被拉伸。
 * 当然，这需要付出一定的性能代价，但是大多数时候都不值得担心。
 * 仔细观察颜色的边缘：它们看起来参差不齐，但也模糊。
 * 锯齿状的部分来自原始图像，因为它的大小仅为66x92像素，
 * 但是模糊的部分是SwiftUI试图在拉伸像素时对其进行融合以使拉伸不那么明显的地方。
 *
 * 通常，这种混合效果很好，但是在这里却很难解决，
 * 因为源图片很小（因此需要以我们想要的大小显示很多混合图像），
 * 并且图像中有很多纯色，因此混合像素显得突出很明显。
 * 对于这种情况，SwiftUI为我们提供了interpolation()修饰符，
 * 使我们可以控制如何应用像素融合。
 * 这有多个层次，但实际上，我们只关心以下一个层次：.none。
 * 这将完全关闭图像插值，
 * 因此，与其混合像素，不如将它们放大而具有锐利的边缘。
 *
 */
struct ImageInterpolationDemo: View {
    var body: some View {
        Image("example")
            .interpolation(.none) // 插值方式
        .resizable()
        .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

// Result 的使用
struct ResultDemo1: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                self.fetchData(from: "https://www.apple.com") { result in
                    switch result {
                        case .success(let str):
                            print(str)
                        case .failure(let error):
                            switch error {
                                case .badURL:
                                    print("Bad URL")
                                case .requestFailed:
                                    print("Network problems")
                                case .unknown:
                                    print("Unknown error")
                        }
                    }
                }
            }
    }
    
    enum NetWorkError: Error {
        case badURL, requestFailed, unknown
    }
    
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetWorkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }
    }
}


// TabView Demo: 注意 .tag 和 selectedTab
struct TabViewDemo1: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    self.selectedTab = 1
            }
            .tabItem {
                Image(systemName: "star")
                Text("One")
            }
            .tag(0)
            
            
            Text("Tab 2")
                .tabItem {
                    Text("Two")
                    Image(systemName: "star.fill")
            }
            .tag(1)
        }
    }
}
