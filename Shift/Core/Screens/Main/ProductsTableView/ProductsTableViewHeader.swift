//
//  ProductsTableViewHeader.swift
//  Shift
//
//  Created by Роман on 05.07.2025.
//

import UIKit

final class ProductsTableViewHeader: UIView {

    private var idLabel: UILabel!
    private var titleLabel: UILabel!
    private var priceLabel: UILabel!
    private var ratingImage: UIImageView!

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    @available(
        *,
        unavailable,
        message: "This initializer is not available. Use init(frame:) instead."
    )
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

extension ProductsTableViewHeader {

    private func setupUI() {
        backgroundColor = .systemGray5

        idLabel = CustomParagraphLabel(text: "ID", fontSize: 20)
        titleLabel = CustomParagraphLabel(text: "Название", fontSize: 20)
        priceLabel = CustomParagraphLabel(text: "Цена", fontSize: 20)

        ratingImage = UIImageView(image: UIImage(systemName: "star"))
        ratingImage.tintColor = .magenta
        let ratingImageContainer = UIView()
        ratingImageContainer.addSubview(ratingImage)

        let stackView = createFieldStackView(
            for: [
                idLabel,
                titleLabel,
                priceLabel,
                ratingImageContainer,
            ]
        )

        self.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview().inset(2)
        }

        idLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.15)
        }

        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.45)
        }

        priceLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.30)
        }

        ratingImageContainer.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.10)
        }

        ratingImage.snp.makeConstraints {
            $0.leading.equalTo(ratingImageContainer.snp.leading).offset(1)
            $0.centerY.equalTo(ratingImageContainer.snp.centerY)
            $0.width.height.equalTo(30)
        }
    }

    // MARK: - UI components bases

    private func createFieldStackView(for arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 12

        return stackView
    }
}
