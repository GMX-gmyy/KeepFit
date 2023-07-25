//
//  ShowViewController.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/25.
//

import Foundation
import UIKit

class KFShowViewController: KFBaseViewController {
    
    private var dataSource: [KFRecordModel] = []
    
    private lazy var nullBgLabel: UILabel = {
        let label = UILabel()
        label.text = "还没有记录呦～\n快去跟练记录一下你的感受吧～"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var showTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShowCell.self, forCellReuseIdentifier: "ShowCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource = KFRecordManager.share.getRecordInfo().reversed()
        showTableView.reloadData()
        if dataSource.isEmpty {
            showTableView.isHidden = true
            nullBgLabel.isHidden = false
        } else {
            showTableView.isHidden = false
            nullBgLabel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(patternImage: (UIImage(named: "secondView")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch))!)
        
        naviRightButtonImage = "yinsi"
        
        view.addSubview(nullBgLabel)
        nullBgLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(24)
            make.right.equalTo(-24)
        }
        
        view.addSubview(showTableView)
        showTableView.snp.makeConstraints { make in
            make.top.equalTo(kNavigationBarHeight + 150)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-(kTabbarHeight + 20))
        }
    }
    
    override func rightButtonEvent() {
        super.rightButtonEvent()
        
        let vc = KFPrivacyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension KFShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as? ShowCell
        cell?.record = dataSource[indexPath.row]
        return cell ?? ShowCell()
    }
}

class ShowCell: UITableViewCell {
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var bambooImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bambooLeaf"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var borderImageView: UIImageView = {
        let imaegView = UIImageView(image: UIImage(named: "tableBg"))
        imageView?.contentMode = .scaleAspectFill
        return imaegView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var showContentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.bottom.equalTo(-12)
            make.left.right.equalToSuperview()
        }
        
        bgView.addSubview(bambooImageView)
        bambooImageView.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.left.equalTo(-15)
            make.width.equalTo(113)
            make.height.equalTo(75)
        }
        
        bgView.addSubview(borderImageView)
        borderImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        borderImageView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(48)
            make.left.equalTo(64)
            make.right.equalTo(-24)
            make.height.equalTo(20)
        }
        
        bgView.addSubview(showContentLabel)
        showContentLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.bottom.equalTo(-48)
            make.left.equalTo(64)
            make.right.equalTo(-24)
        }
    }
    
    var record: KFRecordModel? {
        didSet {
            if let record = record {
                timeLabel.text = record.date
                showContentLabel.text = record.record
            }
        }
    }
}
