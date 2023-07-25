//
//  BaseViewController.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/25.
//

import Foundation
import UIKit

class KFBaseViewController: UIViewController {
    
    public lazy var naviView: KFBaseNavigationView = {
        let view = KFBaseNavigationView()
        return view
    }()
    
    public var barView: UIView {
        get {
            return naviView.barView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        let viewControllers = self.navigationController?.viewControllers
        if self == viewControllers?.first {
            isBackHidden = true
        }
        
        self.view.addSubview(naviView)
        naviView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
        }
        
        naviView.backBlock = { [weak self] in
            guard let `self` = self else { return }
            self.backButtonEvent()
        }
        
        naviView.rightBlock = { [weak self] in
            guard let `self` = self else { return }
            self.rightButtonEvent()
        }
    }
    
    var naviTitle: String = "" {
        didSet {
            naviView.naviTitle.text = naviTitle
        }
    }
    
    var naviRightButtonImage: String? {
        didSet {
            if let image = naviRightButtonImage {
                naviView.naviRight.setBackgroundImage(UIImage(named: image), for: .normal)
            }
        }
    }
    
    var isNaviShow: Bool = true {
        didSet {
            naviView.isHidden = !isNaviShow
        }
    }
    
    var isBackHidden: Bool = false {
        didSet {
            naviView.naviBack.isHidden = isBackHidden
        }
    }
    
    var isTitleHidden: Bool = false {
        didSet {
            naviView.naviTitle.isHidden = isTitleHidden
        }
    }
    
    var isRightHidden: Bool = false {
        didSet {
            naviView.naviRight.isHidden = !isRightHidden
        }
    }
    
    public func backButtonEvent() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func rightButtonEvent() {
        
    }
}
