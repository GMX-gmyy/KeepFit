//
//  BaseNavigationView.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/25.
//

import Foundation
import UIKit
import SnapKit

class KFBaseNavigationView: UIView {
    
    var backBlock: (() -> ())?
    var rightBlock: (() -> ())?
    
    public lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    public lazy var naviBack: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backEvent), for: .touchUpInside)
        return button
    }()
    
    public lazy var naviTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    public lazy var naviRight: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(rightEvent), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(barView)
        barView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(kStatusBarHeight)
        }
        
        barView.addSubview(naviBack)
        naviBack.snp.makeConstraints { make in
            make.left.equalTo(40)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        barView.addSubview(naviTitle)
        naviTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        barView.addSubview(naviRight)
        naviRight.snp.makeConstraints { make in
            make.right.equalTo(-40)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    @objc func backEvent() {
        backBlock?()
    }
    
    @objc func rightEvent() {
        rightBlock?()
    }
}
