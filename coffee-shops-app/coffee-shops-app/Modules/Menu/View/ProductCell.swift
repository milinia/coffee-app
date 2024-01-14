//
//  ProductCell.swift
//  coffee-shops-app
//
//  Created by Evelina on 12.01.2024.
//

import UIKit
import Kingfisher

protocol ProductCellDelegate: AnyObject {
    func increaseAmount(product: MenuItem)
    func deсreaseAmount(product: MenuItem)
}

class ProductCell: UICollectionViewCell {
    // MARK: - Private constants
    private enum UIConstants {
        static let contentInset: CGFloat = 10
        static let itemNameLabelFontSize: CGFloat = 15
        static let itemPriceLabelFontSize: CGFloat = 14
        static let cellCornerRadius: CGFloat = 10
        static let shadowCornerRadius: CGFloat = 2
        static let shadowPathCornerRadius: CGFloat = 5
        static let shadowOffsetHeight: CGFloat = 2
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOpacity: Float = 0.1
        static let verticalStackSpacing: CGFloat = 12
        static let horizontalStackSpacing: CGFloat = 8
        static let imageViewHeight: CGFloat = 137
    }
    
    private var menuItem: MenuItem?
    weak var delegate: ProductCellDelegate?
    
    //MARK: - Private UI properties
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = UIColor.gray
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Medium",
                            size: UIConstants.itemNameLabelFontSize)
        label.textColor = Asset.darkBeigeColor.color
        return label
    }()
    
    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Bold",
                            size: UIConstants.itemPriceLabelFontSize)
        label.textColor = Asset.lightBrownColor.color
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Regular",
                            size: UIConstants.itemPriceLabelFontSize)
        label.textColor = Asset.darkBeigeColor.color
        label.text = "0"
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.plusIcon.image, for: .normal)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.minusIcon.image, for: .normal)
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
            if let product = menuItem {
                delegate?.deсreaseAmount(product: product)
            }
        }
    }
    
    @objc func plusButtonPressed() {
        let number = Int(amountLabel.text ?? "1") ?? 1
        if number < 10 {
            amountLabel.text = String(number + 1)
            if let product = menuItem {
                delegate?.increaseAmount(product: product)
            }
        }
    }
   
       // MARK: - Public function
    func configure(with item: MenuItem) {
        if let imageUrl = URL(string: item.imageURL) {
            loadingView.startAnimating()
            itemImageView.kf.setImage(with: imageUrl) { resu in
                self.loadingView.stopAnimating()
            }
        }
        itemNameLabel.text = item.name
        itemPriceLabel.text = String(item.price) + " руб"
        self.menuItem = item
    }
   
       // MARK: - Private function
    private func initialize() {
        setupView()
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.spacing = UIConstants.verticalStackSpacing
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fill
        vStack.spacing = UIConstants.verticalStackSpacing
        
        let hStackForAmount = UIStackView()
        hStackForAmount.axis = .horizontal
        hStackForAmount.distribution = .fill
        hStackForAmount.spacing = UIConstants.horizontalStackSpacing
        
        let view = UIView()
        view.layer.cornerRadius = UIConstants.cellCornerRadius
        view.clipsToBounds = true
        
        addSubview(view)
        [itemImageView, vStack].forEach({view.addSubview($0)})
        itemImageView.addSubview(loadingView)
        [itemPriceLabel, hStackForAmount].forEach({hStack.addArrangedSubview($0)})
        [itemNameLabel, hStack].forEach({vStack.addArrangedSubview($0)})
        [minusButton, amountLabel, plusButton].forEach({hStackForAmount.addArrangedSubview($0)})
        
        view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        itemImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIConstants.imageViewHeight)
        }
        vStack.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview().inset(UIConstants.contentInset)
            make.top.equalTo(itemImageView.snp.bottom).offset(UIConstants.contentInset)
        }
        hStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        contentView.layer.cornerRadius = UIConstants.cellCornerRadius
        contentView.layer.masksToBounds = true
        layer.cornerRadius = UIConstants.cellCornerRadius
        layer.masksToBounds = false
        
        layer.shadowRadius = UIConstants.shadowCornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = UIConstants.shadowOpacity
        layer.shadowOffset = CGSize(width: UIConstants.shadowOffsetWidth, height: UIConstants.shadowOffsetHeight)
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: UIConstants.shadowPathCornerRadius
        ).cgPath
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: UIConstants.shadowPathCornerRadius
            ).cgPath
        }
}
