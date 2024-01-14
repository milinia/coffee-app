//
//  MenuView.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import UIKit

protocol MenuViewProtocol: AnyObject {
    var presenter: MenuPresenterProtocol? { get set }
    func updateCollectionView(with menu: [MenuItem])
}

class MenuView: UIViewController, MenuViewProtocol {
    var presenter: MenuPresenterProtocol?
    private var menu: [MenuItem] = []
    
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 10
        static let buttonInset: CGFloat = 16
        static let buttonVerticalInsets: CGFloat = 13
        static let buttonCornerRadius: CGFloat = 20
        static let collectionViewCellHeight: CGFloat = 210
        static let buttonHorizontalInsets: CGFloat = 20
        static let collectionViewDispanceBetweenRows: CGFloat = 13
        static let collectionViewDispanceBetweenColumns: CGFloat = 13
        static let buttonTitleFontSize: CGFloat = 18
        static let topContentInset: CGFloat = 15
    }
    
    //MARK: - Private UI properties
    private lazy var payButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont(name: "SFUIDisplay-Bold", size: UIConstants.buttonTitleFontSize)
        let attributedString = AttributedString(Strings.Menu.toOrder, attributes: container)
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
    
    private lazy var menuCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        payButton.addTarget(self, action: #selector(payButtonPressed), for: .touchUpInside)
        presenter?.viewDidLoaded()
    }
    // MARK: - Button actions
    @objc func payButtonPressed() {
        presenter?.openOrderScreen(order: [OrderItem(product: menu[0], amount: 3)])
    }
    
    // MARK: - MenuViewProtocol implementation
    func updateCollectionView(with menu: [MenuItem]) {
        self.menu = menu
        DispatchQueue.main.async {
            self.menuCollection.reloadData()
        }
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = Strings.Menu.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        [menuCollection, payButton].forEach({view.addSubview($0)})
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupConstraints() {
        payButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(UIConstants.buttonInset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(UIConstants.buttonInset)
        }
        
        menuCollection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(UIConstants.topContentInset)
            make.trailing.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalTo(payButton.snp.top).inset(UIConstants.contentInset)
        }
    }
    
    private func setupCollectionView() {
        menuCollection.register(ProductCell.self, forCellWithReuseIdentifier: String(describing: ProductCell.self))
        menuCollection.delegate = self
        menuCollection.dataSource = self
    }
}

extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else { return ProductCell()}
        cell.configure(with: menu[indexPath.row])
        cell.delegate = presenter
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemHeight = UIConstants.collectionViewCellHeight
        let itemWidth = (collectionView.bounds.width - 20) / 2
        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIConstants.collectionViewDispanceBetweenColumns
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIConstants.collectionViewDispanceBetweenRows
    }
}
