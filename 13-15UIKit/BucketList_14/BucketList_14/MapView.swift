//
//  MapView.swift
//  BucketList_14
//
//  Created by DR_Kun on 2020/3/11.
//  Copyright © 2020 kun. All rights reserved.
//


import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // 地图发生移动时调用
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        // 自定义大头针
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        return coordinator
    }
    
    // UIViewRepresentable 内部定义了  typealias Context = UIViewRepresentableContext<Self>
    // 所以可以直接使用 Context 替换掉 UIViewRepresentableContext<MapView>
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        // 添加大头针
        let annotation = MKPointAnnotation()
        annotation.title = "老家"
        annotation.subtitle = "出生的地方"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 33.422119, longitude: 115.322696)
        mapView.addAnnotation(annotation)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }

}
