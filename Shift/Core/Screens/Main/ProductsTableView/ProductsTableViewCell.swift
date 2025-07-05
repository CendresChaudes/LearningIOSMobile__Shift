//
//  ProductsTableViewCell.swift
//  Shift
//
//  Created by Роман on 05.07.2025.
//

import UIKit

final class ProductsTableViewCell: UITableViewCell {

    private var idLabel: UILabel!
    private var titleLabel: UILabel!
    private var priceLabel: UILabel!
    private var ratingLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    @available(
        *,
        unavailable,
        message: "This initializer is not available. Use init(style:reuseIdentifier:) instead."
    )
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(with product: Product) {
        idLabel.text = "\(product.id)"
        titleLabel.text = product.title
        priceLabel.text = "\(product.price)"
        ratingLabel.text = "\(product.rating.rate)"

        setRatingLabelColor(rating: product.rating)
    }
}

// MARK: - Setup UI

extension ProductsTableViewCell {

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        idLabel = CustomParagraphLabel(text: "N/A", fontSize: 20)
        titleLabel = CustomParagraphLabel(text: "N/A", fontSize: 20)
        priceLabel = CustomParagraphLabel(text: "N/A", fontSize: 20)
        ratingLabel = CustomParagraphLabel(text: "N/A", fontSize: 20)

        let stackView = createFieldStackView(for: [idLabel, titleLabel, priceLabel, ratingLabel])
        contentView.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
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

        ratingLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.10)
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
    
    private func setRatingLabelColor(rating: Rating) {
        switch rating.rate {
        case 0..<1.5:
            ratingLabel.textColor = .systemRed
        case 1.5..<3:
            ratingLabel.textColor = .systemOrange
        case 3..<4:
            ratingLabel.textColor = .systemYellow
        case 4...:
            ratingLabel.textColor = .systemGreen
        default:
            ratingLabel.textColor = .systemGray
        }
    }
}
