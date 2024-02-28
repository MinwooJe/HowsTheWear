//
//  LoginView.swift
//  HowsTheWear
//
//  Created by 성대훈 on 2/6/24.
//

import UIKit

import SnapKit
import Then

final class LoginView: UIView,UITextFieldDelegate {
    private let titleWidth = 100.0
    
    private let titleLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .pretendard(size: 20, weight: .semibold)
        $0.textColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
    }
    
    private let idLabel = UILabel().then {
        $0.text = "아이디"
        $0.font = .pretendard(size: 15, weight: .medium)
        $0.textColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1)
    }
    
    let idTextField = UITextField().then {
        $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.placeholder = "아이디를 입력해주세요"
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        $0.clipsToBounds = true
        $0.textColor = UIColor.black
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    
    private lazy var idView = UIStackView(arrangedSubviews: [idLabel,idTextField]).then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillProportionally
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
    }
    
    private let pwLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .pretendard(size: 15, weight: .medium)
        $0.textColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1)
    }
    
    let pwTextField = UITextField().then {
        $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1).cgColor
        $0.clipsToBounds = true
        $0.textColor = UIColor.black
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.isSecureTextEntry = true
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    
    private lazy var pwView = UIStackView(arrangedSubviews: [pwLabel,pwTextField]).then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillProportionally
    }
    
    private let pwEyeIcon = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        $0.tintColor = #colorLiteral(red: 0.5141947269, green: 0.5141947269, blue: 0.5141947269, alpha: 1)
    }
    
    let confirmButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setAttributedTitle(
            NSAttributedString(
                string: "확인",
                attributes: [
                    .font: UIFont.pretendard(size: 14, weight: .medium),
                    .foregroundColor: UIColor.white
                ]
            ), for: .normal
        )
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 13
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = #colorLiteral(red: 0.980392158, green: 0.980392158, blue: 0.980392158, alpha: 1)
        addSubviews([
            titleLabel,
            idView,
            separatorView,
            pwView, pwEyeIcon,
            confirmButton
        ])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            $0.left.equalTo(20)
        }
        
        idLabel.snp.makeConstraints {
            $0.width.equalTo(titleWidth)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        idView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.left.equalTo(titleLabel)
        }
        
        separatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(idView.snp.bottom).offset(16)
            $0.left.equalTo(idView)
            $0.height.equalTo(1)
        }
        
        pwLabel.snp.makeConstraints {
            $0.width.equalTo(titleWidth)
        }
        
        pwTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        pwView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(separatorView.snp.bottom).offset(16)
            $0.left.equalTo(separatorView)
        }
        
        pwEyeIcon.snp.makeConstraints {
            $0.centerY.equalTo(pwView)
            $0.top.equalTo(pwView.snp.top).inset(10)
            $0.right.equalTo(pwView.snp.right).inset(10)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalTo(titleLabel)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.height.equalTo(50)
        }
    }
    
}
