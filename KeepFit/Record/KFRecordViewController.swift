//
//  RecordViewController.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/25.
//

import Foundation
import UIKit

class KFRecordViewController: KFBaseViewController {
    
    private lazy var dateView: TitleTab  = {
        let view = TitleTab()
        view.title = "Date"
        return view
    }()
    
    private lazy var contentBgView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor(r: 250, g: 250, b: 250)
        view.layer.cornerRadius = 6
        view.layer.shadowColor = kColor(r: 0, g: 0, b: 0, 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = KFDateManager.getCurrentTime(timeFormat: "YYYY-MM-dd HH:mm")
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var thisFeelingView: TitleTab  = {
        let view = TitleTab()
        view.title = "This Feeling"
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "startButton"), for: .normal)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        return button
    }()
    
    private lazy var thisFeelingBgView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor(r: 250, g: 250, b: 250)
        view.layer.cornerRadius = 6
        view.layer.shadowColor = kColor(r: 0, g: 0, b: 0, 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    private lazy var thisFeelingTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 14)
        return textView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabel.text = KFDateManager.getCurrentTime(timeFormat: "YYYY-MM-dd HH:mm")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(patternImage: (UIImage(named: "secondView")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch))!)
        
        view.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.top.equalTo(kNavigationBarHeight + 150)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(contentBgView)
        contentBgView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(12)
            make.left.equalTo(61)
            make.right.equalTo(-61)
            make.height.equalTo(50)
        }
        
        contentBgView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.left.equalTo(4)
            make.bottom.right.equalTo(-4)
        }
        
        view.addSubview(thisFeelingView)
        thisFeelingView.snp.makeConstraints { make in
            make.top.equalTo(contentBgView.snp.bottom).offset(12)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(-(kTabbarHeight + 20))
            make.centerX.equalToSuperview()
            make.width.equalTo(199)
            make.height.equalTo(71)
        }
        
        view.addSubview(thisFeelingBgView)
        thisFeelingBgView.snp.makeConstraints { make in
            make.left.equalTo(61)
            make.right.equalTo(-61)
            make.top.equalTo(thisFeelingView.snp.bottom).offset(12)
            make.bottom.equalTo(saveButton.snp.top).offset(-20)
        }
        
        thisFeelingBgView.addSubview(thisFeelingTextView)
        thisFeelingTextView.snp.makeConstraints { make in
            make.top.left.equalTo(4)
            make.bottom.right.equalTo(-4)
        }
    }
    
    @objc func saveEvent() {
        let model = KFRecordModel()
        model.date = dateLabel.text
        model.record = thisFeelingTextView.text
        KFRecordManager.share.saveRecordInfo(model: model)
        let alertView = UIAlertController(title: "", message: "Save succesfully!", preferredStyle: .alert)
        self.present(alertView, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            alertView.dismiss(animated: true)
            let tabVc = self.navigationController?.tabBarController
            tabVc?.selectedIndex = 2
            self.thisFeelingTextView.text = ""
        }
    }
}

class TitleTab: UIView {
    
    private lazy var bambooLeafImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bambooLeaf"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
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
        
        addSubview(bambooLeafImageView)
        bambooLeafImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(79)
            make.height.equalTo(49)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(bambooLeafImageView.snp.right).offset(12)
            make.right.equalToSuperview()
            make.height.equalTo(27)
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
}


