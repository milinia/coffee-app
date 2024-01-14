//
//  CoffeeShopsMapView.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import UIKit
import YandexMapsMobile

protocol CoffeeShopsMapViewProtocol: AnyObject {
    var presenter: CoffeeShopsMapPresenterProtocol? { get set }
    func addAnnotations(with coffeeShops: [CoffeeShop])
}

class CoffeeShopsMapView: UIViewController, CoffeeShopsMapViewProtocol {
    
    var presenter: CoffeeShopsMapPresenterProtocol?

    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 10
        static let buttonInset: CGFloat = 16
        static let buttonVerticalInsets: CGFloat = 13
        static let buttonCornerRadius: CGFloat = 20
        static let titleFontSize: CGFloat = 18
        static let annotationTitleFontSize: Float = 14.0
        static let cameraPositionZoom: Float = 9.0
        static let cameraPositionAzimuth: Float = 150.0
        static let cameraPositionTilt: Float = 30.0
        static let coffeeShopIconScale: NSNumber = 3.0
        static let cameraMoveAnimationDuration: Float = 1.0
    }
    
    private lazy var mapInterface: YMKMap? = mapView.mapWindow.map
    private lazy var mapObjectTapListener: MapObjectTapListener = MapObjectTapListener(controller: self)
    
    //MARK: - Private UI properties    
    private lazy var mapView: YMKMapView = {
        let map = YMKMapView(frame: view.frame)
        return map ?? YMKMapView()
    }()
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        presenter?.viewDidLoaded()
        mapObjectTapListener.delegate = presenter
    }
    
    // MARK: - CoffeeShopsMapViewProtocol realization
    
    func addAnnotations(with coffeeShops: [CoffeeShop]) {
        setMapRegion(latitude: Double(coffeeShops[0].coffeeShop.point.latitude) ?? 0,
                     longitude: Double(coffeeShops[0].coffeeShop.point.longitude) ?? 0)
        coffeeShops.forEach { shop in
            let placemark = mapInterface?.mapObjects.addPlacemark()
            placemark?.geometry = YMKPoint(latitude: Double(shop.coffeeShop.point.latitude) ?? 0,
                                          longitude: Double(shop.coffeeShop.point.longitude) ?? 0)
            let iconStyle = YMKIconStyle()
            iconStyle.scale = UIConstants.coffeeShopIconScale
            placemark?.setIconWith(Asset.coffeeIcon.image, style: iconStyle)
            placemark?.setTextWithText(
                shop.coffeeShop.name,
                style: YMKTextStyle(
                    size: UIConstants.annotationTitleFontSize,
                    color: Asset.lightBrownColor.color,
                    outlineColor: .white,
                    placement: .bottom,
                    offset: 0.0,
                    offsetFromIcon: true,
                    textOptional: false
                )
            )
            placemark?.isDraggable = true
            placemark?.addTapListener(with: mapObjectTapListener)
        }
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = Strings.CoffeeShopMap.title
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Asset.lightBrownColor.color,
            NSAttributedString.Key.font: UIFont(name: "SFUIDisplay-Bold", size: UIConstants.titleFontSize)
        ]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = Asset.lightBrownColor.color
        
        view.addSubview(mapView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setMapRegion(latitude: Double, longitude: Double) {
        let point = YMKPoint(latitude: latitude, longitude: longitude)
        let cameraPosition: YMKCameraPosition = YMKCameraPosition(target: point, zoom: UIConstants.cameraPositionZoom,
                                                                  azimuth: UIConstants.cameraPositionAzimuth,
                                                                  tilt: UIConstants.cameraPositionTilt)
        mapInterface?.move(with: cameraPosition,
                           animation: YMKAnimation(type: .smooth, duration: UIConstants.cameraMoveAnimationDuration))
    }
}
