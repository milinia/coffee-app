//
//  MapObjectTapListener.swift
//  coffee-shops-app
//
//  Created by Evelina on 14.01.2024.
//

import Foundation
import YandexMapsMobile

protocol MapObjectTapListenerDelegate: AnyObject {
    func mapWasTapped(latitude: Double, longitude: Double)
}

final class MapObjectTapListener: NSObject, YMKMapObjectTapListener {
    private weak var controller: UIViewController?
    weak var delegate: MapObjectTapListenerDelegate?
    
    init(controller: UIViewController) {
        self.controller = controller
    }

    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        delegate?.mapWasTapped(latitude: point.latitude, longitude: point.longitude)
        return true
    }
}
