//
//  CoffeeShopListView.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import UIKit

protocol CoffeeShopListViewProtocol: AnyObject {
    var presenter: CoffeeShopListPresenter? { get set }
    func updateCollectionView(with coffeeShops: [CoffeeShop])
}

class CoffeeShopListView: UIViewController, CoffeeShopListViewProtocol {
    var presenter: CoffeeShopListPresenter?
    private var coffeeShops: [CoffeeShop] = []
    
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 10
        static let buttonInset: CGFloat = 16
        static let buttonVerticalInsets: CGFloat = 13
        static let buttonCornerRadius: CGFloat = 20
        static let collectionViewCellHeight: CGFloat = 71
        static let buttonHorizontalInsets: CGFloat = 20
        static let collectionViewDispanceBetweenRows: CGFloat = 6
        static let collectionViewDispanceBetweenColumns: CGFloat = 0
        static let buttonTitleFontSize: CGFloat = 18
        static let topContentInset: CGFloat = 15
    }
    
    //MARK: - Private UI properties
    private lazy var showOnMapButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont(name: "SFUIDisplay-Bold", size: UIConstants.buttonTitleFontSize)
        let attributedString = AttributedString(Strings.CoffeeShopList.onMap, attributes: container)
        configuration.attributedTitle = attributedString
        configuration.baseBackgroundColor = Asset.darkBrownColor.color
        configuration.baseForegroundColor = Asset.beigeColor.color
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: UIConstants.buttonVerticalInsets,
            leading: UIConstants.buttonHorizontalInsets,
            bottom: UIConstants.buttonVerticalInsets,
            trailing: UIConstants.buttonHorizontalInsets
        )
        configuration.background.cornerRadius = UIConstants.buttonCornerRadius
        configuration.cornerStyle = .fixed
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    private lazy var coffeeShopCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    // MARK: - CoffeeShopListViewProtocol implementation
    func updateCollectionView(with coffeeShops: [CoffeeShop]) {
        self.coffeeShops = coffeeShops
        DispatchQueue.main.async {
            self.coffeeShopCollection.reloadData()
        }
    }
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoaded()
        
        showOnMapButton.addTarget(self, action: #selector(showOnMapButtonPressed), for: .touchUpInside)
    }
    // MARK: - Button actions
    @objc func showOnMapButtonPressed() {
        presenter?.openMapScreen(coffeeShops: coffeeShops)
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = Strings.CoffeeShopList.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        [coffeeShopCollection, showOnMapButton].forEach({view.addSubview($0)})
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupConstraints() {
        showOnMapButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(UIConstants.buttonInset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(UIConstants.buttonInset)
        }
        
        coffeeShopCollection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(UIConstants.topContentInset)
            make.trailing.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalTo(showOnMapButton.snp.top).inset(UIConstants.contentInset)
        }
    }
    
    private func setupCollectionView() {
        coffeeShopCollection.register(CoffeeShopCell.self, forCellWithReuseIdentifier: String(describing: CoffeeShopCell.self))
        coffeeShopCollection.delegate = self
        coffeeShopCollection.dataSource = self
    }
}

extension CoffeeShopListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeShops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CoffeeShopCell.self), for: indexPath) as? CoffeeShopCell else { return CoffeeShopCell()}
        cell.configure(with: coffeeShops[indexPath.row].coffeeShop.name, distance: coffeeShops[indexPath.row].distanceFromUser)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.openMenuScreen(index: coffeeShops[indexPath.row].coffeeShop.id)
    }
}

extension CoffeeShopListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = UIConstants.collectionViewCellHeight
        let itemWidth = collectionView.bounds.width
        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIConstants.collectionViewDispanceBetweenColumns
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIConstants.collectionViewDispanceBetweenRows
    }
}
