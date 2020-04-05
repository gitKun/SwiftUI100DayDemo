//
//  BUGTransition.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/4/2.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI



fileprivate extension AnyTransition {
    static var moveToOpacity: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}


fileprivate class CModel: Identifiable {
    let id = UUID()
}



struct BUGTransition: View {
    var body: some View {
        ShowOrHiddenAnimation2()
    }
}

// NavigationView 内部包裹的 ZStcak 使用 ZStcak ==> transition无问题,navigationBar 无法遮挡
fileprivate struct ShowOrHiddenAnimation4: View {
    @State private var model: CModel? = nil
    var body: some View {
            NavigationView {
                ZStack {
                    Button("Tap Me") {
                        withAnimation(.easeOut(duration: 3)) {
                            self.model = CModel()
                        }
                    }
                    if self.model != nil {
                        FullScreenView1(model: $model)
                    }
                }
                .navigationBarTitle("xxx", displayMode: .inline)
            }
    }
}
// ZStcak 内部包裹 NavigationView 后使用 Group ==> transition的insert无问题removal无效,navigationBar 完美遮挡
fileprivate struct ShowOrHiddenAnimation3: View {
    @State private var model: CModel? = nil
    var body: some View {
        ZStack {
            NavigationView {
                Button("Tap Me") {
                    withAnimation(.easeOut(duration: 3)) {
                        self.model = CModel()
                    }
                }
                .navigationBarTitle("xxx", displayMode: .inline)
            }
            if self.model != nil {
                /*
                Color.pink.edgesIgnoringSafeArea(.all)
                    .transition(.moveToOpacity)
                    .animation(.easeOut(duration: 3))
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 3)) {
                            self.model = nil
                        }
                    }
                */
                FullScreenView2(model: $model)
            }
        }
    }
}
// ZStcak 内部包裹 NavigationView 后使用 ZStack ==> transition的insert无问题removal无效,navigationBar 完美遮挡
fileprivate struct ShowOrHiddenAnimation2: View {
    @State private var model: CModel? = nil
    var body: some View {
        ZStack {
            NavigationView {
                Button("Tap Me") {
                    withAnimation(.easeOut(duration: 3)) {
                        self.model = CModel()
                    }
                }
                .navigationBarTitle("xxx", displayMode: .inline)
            }
            if self.model != nil {
                FullScreenView1(model: $model)
            }
        }
    }
}
// ZStack 内部直接使用 ZStack ==> transition无问题,未使用 navigationBar
fileprivate struct ShowOrHiddenAnimation1: View {
    @State private var model: CModel? = nil
    var body: some View {
        ZStack {
            Button("Tap Me") {
                withAnimation(.easeOut(duration: 3)) {
                    self.model = CModel()
                }
            }
            if self.model != nil {
                FullScreenView1(model: $model)
            }
        }
    }
}

// 内部指定使用 ZStack
fileprivate struct FullScreenView1: View {
    @Binding var model: CModel?
    var body: some View {
        ZStack {
            Color.pink.edgesIgnoringSafeArea(.all)
        }
        .transition(.moveToOpacity)
        .animation(.easeOut(duration: 3))
        .onTapGesture {
            withAnimation(.easeOut(duration: 3)) {
                self.model = nil
            }
        }
    }
}

// 使用 Group 包装,布局由外部决定
fileprivate struct FullScreenView2: View {
    @Binding var model: CModel?
    var body: some View {
        Group {
            Color.pink.edgesIgnoringSafeArea(.all)
            NavigationView {
                Text("FullScreenView2")
            }
        }
        .transition(.moveToOpacity)
        .animation(.easeOut(duration: 3))
        .onTapGesture {
            withAnimation(.easeOut(duration: 3)) {
                self.model = nil
            }
        }
    }
}


struct BUGTransition_Previews: PreviewProvider {
    static var previews: some View {
        BUGTransition()
    }
}



