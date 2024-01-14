//
//  OrderCell.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import UIKit

class OrderCell: UICollectionViewCell {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 10
        static let itemNameLabelFontSize: CGFloat = 18
        static let itemPriceLabelFontSize: CGFloat = 14
        static let verticalStackViewSpacing: CGFloat = 6
        static let cellCornerRadius: CGFloat = 10
        static let shadowCornerRadius: CGFloat = 2
        static let shadowPathCornerRadius: CGFloat = 5
        static let shadowOffsetHeight: CGFloat = 2
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOpacity: Float = 0.1
        static let verticalStackSpacing: CGFloat = 12
        static let horizontalStackSpacing: CGFloat = 8
    }
    
    //MARK: - Private UI properties
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Bold",
                            size: UIConstants.itemNameLabelFontSize)
        label.textColor = Asset.lightBrownColor.color
        return label
    }()
    
    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Regular",
                            size: UIConstants.itemPriceLabelFontSize)
        label.textColor = Asset.darkBeigeColor.color
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Regular",
                            size: UIConstants.itemPriceLabelFontSize)
        label.textColor = Asset.lightBrownColor.color
        label.text = "0"
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        let image = Asset.plusIcon.image
        button.setImage(image.withTintColor(Asset.lightBrownColor.color), for: .normal)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        let image = Asset.minusIcon.image
        button.setImage(image.withTintColor(Asset.lightBrownColor.color), for: .normal)
        return button
    }()
    
     // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        
        minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button actions
    @objc func minusButtonPressed() {
        let number = Int(amountLabel.text ?? "1") ?? 1
        if number > 0 {
            amountLabel.text = String(number - 1)
        }
    }
    
    @objc func plusButtonPressed() {
        let number = Int(amountLabel.text ?? "1") ?? 1
        if number < 10 {
            amountLabel.text = String(number + 1)
        }
    }
   
       // MARK: - Public function
    func configure(with item: OrderItem) {
        itemNameLabel.text = item.product.name
        itemPriceLabel.text = String(item.product.price) + " руб"
        amountLabel.text = String(item.amount)
    }
   
       // MARK: - Private function
    private func initialize() {
        setupView()
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.spacing = UIConstants.verticalStackViewSpacing
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.alignment = .center
        vStack.spacing = UIConstants.verticalStackSpacing
        
        let hStackForAmount = UIStackView()
        hStackForAmount.axis = .horizontal
        hStackForAmount.distribution = .fill
        hStackForAmount.spacing = UIConstants.horizontalStackSpacing
    
        addSubview(hStack)
        [vStack, hStackForAmount].forEach({hStack.addArrangedSubview($0)})
        [itemNameLabel, itemPriceLabel].forEach({vStack.addArrangedSubview($0)})
        [minusButton, amountLabel, plusButton].forEach({hStackForAmount.addArrangedSubview($0)})
        
        hStack.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview().inset(UIConstants.contentInset)
        }
        vStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
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
