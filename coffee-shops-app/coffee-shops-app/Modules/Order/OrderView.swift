//
//  OrderView.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import UIKit

protocol OrderViewProtocol: AnyObject {
    var presenter: OrderPresenterProtocol? { get set }
}

class OrderView: UIViewController, OrderViewProtocol {
    var presenter: OrderPresenterProtocol?
    private var order: [OrderItem]
    
    init(order: [OrderItem]) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        static let titleFontSize: CGFloat = 18
        static let topContentInset: CGFloat = 15
        static let infoLabelFontSize: CGFloat = 24
    }
    
    //MARK: - Private UI properties
    private lazy var payButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont(name: "SFUIDisplay-Bold", size: UIConstants.buttonTitleFontSize)
        let attributedString = AttributedString(Strings.Order.pay, attributes: container)
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
    
    private lazy var orderCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Medium", size: UIConstants.infoLabelFontSize)
        label.text = Strings.Order.status
        label.textColor = Asset.lightBrownColor.color
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        payButton.addTarget(self, action: #selector(payButtonPressed), for: .touchUpInside)
    }
    // MARK: - Button actions
    @objc func payButtonPressed() {
        presenter?.openCoffeeShopListScreen()
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = Strings.Order.title
        
        [infoLabel, payButton, orderCollection].forEach({view.addSubview($0)})
        view.bringSubviewToFront(infoLabel)
        view.bringSubviewToFront(payButton)
        setupCollectionView()
        setupConstraints()
    }
    
    private func setupConstraints() {
        payButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(UIConstants.buttonInset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(UIConstants.buttonInset)
        }
        
        orderCollection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(UIConstants.topContentInset)
            make.trailing.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.bottom.equalTo(payButton.snp.top).inset(1.5 * UIConstants.contentInset)
        }

        infoLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.centerY.equalToSuperview().offset(120)
        }
    }
    
    private func setupCollectionView() {
        orderCollection.register(OrderCell.self, forCellWithReuseIdentifier: String(describing: OrderCell.self))
        orderCollection.delegate = self
        orderCollection.dataSource = self
    }
}

extension OrderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return order.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OrderCell.self), for: indexPath) as? OrderCell else { return OrderCell()}
        cell.configure(with: order[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension OrderView: UICollectionViewDelegateFlowLayout {
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
