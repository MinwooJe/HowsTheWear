//
//  HourlyCollectionCell.swift
//  HowsTheWear
//
//  Created by RAFA on 1/29/24.
//

import UIKit

import SnapKit
import Then

final class HourlyCollectionCell: UICollectionViewCell {
    
    let timeLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        $0.font = .pretendard(size: 14, weight: .medium)
        $0.textAlignment = .center
    }
    
    let weatherIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let temperatureLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.439, green: 0.439, blue: 0.439, alpha: 1)
        $0.font = .pretendard(size: 14, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [
        timeLabel, weatherIconImageView, temperatureLabel
    ]).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        weatherIconImageView.image = nil
        temperatureLabel.text = nil
        prepare(data: nil)
    }
    
    func prepare(data: Hourly?) {
        timeLabel.text = data?.time
        weatherIconImageView.image = UIImage(systemName: data?.weatherIcon ?? "sun.max.fill")?
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 30))
        weatherIconImageView.layer.masksToBounds = false
        weatherIconImageView.layer.shadowColor = UIColor.black.cgColor
        weatherIconImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        weatherIconImageView.layer.shadowRadius = 20
        weatherIconImageView.layer.shadowOpacity = 0.2
        temperatureLabel.text = data?.temperature
    }
    
}

// MARK: - UI Configuration

private extension HourlyCollectionCell {
    
    func configureUI() {
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}