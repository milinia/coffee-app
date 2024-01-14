//
//  CoffeeShopCell.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import UIKit
import SnapKit

class CoffeeShopCell: UICollectionViewCell {
    
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 10
        static let coffeeShopNameLabelFontSize: CGFloat = 18
        static let distanceFromCoffeeShopLabelFontSize: CGFloat = 14
        static let verticalStackViewSpacing: CGFloat = 6
        static let cellCornerRadius: CGFloat = 10
        static let shadowCornerRadius: CGFloat = 2
        static let shadowPathCornerRadius: CGFloat = 5
        static let shadowOffsetHeight: CGFloat = 2
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOpacity: Float = 0.1
    }
    
    //MARK: - Private UI properties
    private lazy var coffeeShopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Bold",
                            size: UIConstants.coffeeShopNameLabelFontSize)
        label.textColor = Asset.lightBrownColor.color
        return label
    }()
    
    private lazy var distanceFromCoffeeShopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Regular",
                            size: UIConstants.distanceFromCoffeeShopLabelFontSize)
        label.textColor = Asset.darkBeigeColor.color
        return label
    }()
    
     // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
       // MARK: - Public function
    func configure(with name: String, distance: Int) {
        coffeeShopNameLabel.text = name
        distanceFromCoffeeShopLabel.text = String(distance) + Strings.CoffeeShopList.fromYou
    }
   
       // MARK: - Private function
    private func initialize() {
        setupView()
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.spacing = UIConstants.verticalStackViewSpacing
        
        addSubview(vStack)
        [coffeeShopNameLabel, distanceFromCoffeeShopLabel].forEach({vStack.addArrangedSubview($0)})
        vStack.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalToSuperview().inset(UIConstants.contentInset)
        }
    }
    
    private func setupView() {
        backgroundColor = Asset.beigeColor.color
        contentView.layer.cornerRadius = UIConstants.cellCornerRadius
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = UIConstants.cellCornerRadius
        layer.masksToBounds = false

        layer.shadowRadius = UIConstants.shadowCornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = UIConstants.shadowOpacity

        layer.shadowOffset = CGSize(width: UIConstants.shadowOffsetWidth, height: UIConstants.shadowOffsetHeight)
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: UIConstants.shadowPathCornerRadius
            ).cgPath
        }
}
