//
//  HomeViewController.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/25.
//

import Foundation
import UIKit
import AVKit
import MediaPlayer

class KFHomeViewController: KFBaseViewController {
    
    private var playerItem: AVPlayerItem?
    private var playerVc: AVPlayerViewController?
    
    private let original = "The origin of Baduan Jin can be traced back to before the Song Dynasty, and gradually developed and perfected in the Ming and Qing dynasties, and is the crystallization of wisdom shared by successive generations of health practitioners and practitioners. \n\nFitness Qigong Baduan Jin is undertaken by the research group of Beijing Sport University, inheriting the essence of the traditional Baduan Jin genres, basically maintaining the fixed movements and style characteristics of the traditional Baduan Jin, and scientifically and reasonably adjusting the order of movements and exercise intensity in accordance with the laws of modern kinematics and physiology, highlighting the fitness characteristics, making the whole set of exercises more complete, safe and effective. \n\nFitness Qigong Baduan Jin focuses on the comprehensive exercise of Yiqi shape, which is simple and easy, with the characteristics of soft and slow, round and coherent, elastic combination, combination of movement and static, combination of God and form, and qi in it. \n\nScientific research shows that practicing fitness qigong Baduan Jin can help improve the function of the respiratory, nervous system and circulatory system, enhance cellular immune function and the body's anti-aging ability, promote mental health, improve upper and lower limb strength, joint flexibility and balance."
    
    private let notice = "1. Physical condition\n\nAvoid practicing for an hour before and after eating. If you have insomnia, avoid practicing before going to bed. Cardiovascular patients, avoid morning exercises. It is not appropriate to practice after hunger, fullness of food and drinking. Stop practicing when your body is extremely tired or irritable.\n\n2. Environmental conditions\n\nTry to choose a quiet, undisturbed, fresh air, ventilation to the sun, no pollution environment to practice. Practice outside in the winter after the sun comes out. When the wind, fog, rain, snow, cold wave and other bad weather, it is appropriate to choose indoor practice.\n\n3. Dress code\n\nWear loose clothes and not too tight belts. Wear shallow sneakers with soft soles. Don't wear accessories."
    
    private let advise = "1. Tips for beginners\n\nFor beginners, just breathe naturally and don't hold your breath during the exercise.\n\n2. Give advice to intermediate levels\n\nIf you have been practicing for a while and the movements are very skilled, you can try to match the movements with the breathing. The basic principles are: up and down, open and close. \n\nFor example, the two hands supporting the three jiao, the hands crossed to support the breath, exhale when the hands fall. If the frequency of breathing is faster, you can also change the original inhalation to one inhalation, that is, inhale when the hands are crossed to the chest, and exhale when the hands continue to support; Breathe in with your hands apart and your shoulders down, and breathe out with your hands back in front of your abdomen.\n\n3. Give suggestions for the improvement stage\n\nAfter the movement and breathing can be well coordinated, you can try to use abdominal breathing. There are two types of breathing: antero-abdominal breathing and inverse abdominal breathing. \n\nTo put it simply, anteroabdominal breathing, inhaling when the abdomen rises, exhaling when the abdomen pulls in, lifting the anus; Reverse abdominal breathing. Lift the anus and pull in the abdomen while inhaling, and relax and restore when exhaling. \n\nIn contrast, anterograde breathing is easier to perform, while backward breathing massages the internal organs more intensely. Practitioners can choose the appropriate breathing mode according to their actual situation. \n\nOn the pause action, you can try to hold the breath. If the two hands support the three jiao, up to the maximum amplitude, after looking ahead, pause for 2 seconds, while holding the breath for 2 seconds. Patients with hypertension and heart disease cannot use this method."
    
    private lazy var secondTitle: UILabel = {
        let label = UILabel()
        label.text = "Eight-Length\nBrocade Exercise"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var videoButton: KFCommonButton = {
        let button = KFCommonButton()
        button.title = "Video"
        button.isSelected = true
        return button
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 18)
        textView.isHidden = true
        return textView
    }()
    
    private lazy var originalButton: KFCommonButton = {
        let button = KFCommonButton()
        button.title = "Original"
        button.isSelected = false
        return button
    }()
    
    private lazy var noticeButton: KFCommonButton = {
        let button = KFCommonButton()
        button.title = "Notice"
        button.isSelected = false
        return button
    }()
    
    private lazy var adviseButton: KFCommonButton = {
        let button = KFCommonButton()
        button.title = "Advise"
        button.isSelected = false
        return button
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "startButton"), for: .normal)
        button.setTitle("Start", for: .normal)
        button.setTitle("Pause", for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.addTarget(self, action: #selector(start(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        pause()
        startButton.isSelected = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPlayer()
        NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(patternImage: (UIImage(named: "firstView")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch))!)
        
        view.addSubview(secondTitle)
        secondTitle.snp.makeConstraints { make in
            make.right.equalTo(-24)
            make.top.equalTo(kStatusBarHeight + 56)
        }
        
        let buttonW = (kScreenWidth - 40 - 48) / 4.0
        view.addSubview(videoButton)
        videoButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(200 + kNavigationBarHeight)
            make.width.height.equalTo(buttonW)
        }
        videoButton.buttonAction = { [weak self] in
            self?.videoButton.isSelected = true
            self?.originalButton.isSelected = false
            self?.noticeButton.isSelected = false
            self?.adviseButton.isSelected = false
            self?.textView.isHidden = true
            self?.startButton.isHidden = false
            self?.contentBgView.isHidden = false
        }
        
        view.addSubview(originalButton)
        originalButton.snp.makeConstraints { make in
            make.top.equalTo(200 + kNavigationBarHeight)
            make.left.equalTo(videoButton.snp.right).offset(16)
            make.width.height.equalTo(buttonW)
        }
        originalButton.buttonAction = { [weak self] in
            self?.videoButton.isSelected = false
            self?.originalButton.isSelected = true
            self?.noticeButton.isSelected = false
            self?.adviseButton.isSelected = false
            self?.pause()
            self?.startButton.isSelected = false
            self?.startButton.isHidden = true
            self?.textView.isHidden = false
            self?.textView.text = self?.original
            self?.contentBgView.isHidden = true
        }
        
        view.addSubview(noticeButton)
        noticeButton.snp.makeConstraints { make in
            make.top.equalTo(200 + kNavigationBarHeight)
            make.left.equalTo(originalButton.snp.right).offset(16)
            make.width.height.equalTo(buttonW)
        }
        noticeButton.buttonAction = { [weak self] in
            self?.videoButton.isSelected = false
            self?.originalButton.isSelected = false
            self?.noticeButton.isSelected = true
            self?.adviseButton.isSelected = false
            self?.pause()
            self?.startButton.isSelected = false
            self?.startButton.isHidden = true
            self?.textView.isHidden = false
            self?.textView.text = self?.notice
            self?.contentBgView.isHidden = true
        }
        
        view.addSubview(adviseButton)
        adviseButton.snp.makeConstraints { make in
            make.top.equalTo(200 + kNavigationBarHeight)
            make.left.equalTo(noticeButton.snp.right).offset(16)
            make.width.height.equalTo(buttonW)
        }
        adviseButton.buttonAction = { [weak self] in
            self?.videoButton.isSelected = false
            self?.originalButton.isSelected = false
            self?.noticeButton.isSelected = false
            self?.adviseButton.isSelected = true
            self?.pause()
            self?.startButton.isSelected = false
            self?.startButton.isHidden = true
            self?.textView.isHidden = false
            self?.textView.text = self?.advise
            self?.contentBgView.isHidden = true
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(-(kTabbarHeight + 16))
            make.centerX.equalToSuperview()
            make.width.equalTo(199)
            make.height.equalTo(71)
        }
        
        view.addSubview(contentBgView)
        contentBgView.snp.makeConstraints { make in
            make.top.equalTo(videoButton.snp.bottom).offset(20)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.bottom.equalTo(startButton.snp.top).offset(-12)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalTo(contentBgView)
        }
    }
    
    private func setupPlayer() {
        playerVc = AVPlayerViewController()
        playerItem = AVPlayerItem.init(url: URL(fileURLWithPath: Bundle.main.path(forResource: "baduanjin", ofType: "mp4")!))
        playerVc?.player = AVPlayer(playerItem: playerItem)
        playerVc?.videoGravity = .resizeAspect
        playerVc?.showsPlaybackControls = true
        playerVc?.showsTimecodes = true
        contentBgView.addSubview((playerVc?.view)!)
        playerVc?.view.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    @objc func start(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            play()
        } else {
            pause()
        }
    }
    
    private func play() {
        guard let player = playerVc?.player else { return }
        player.play()
    }
    
    private func pause() {
        guard let player = playerVc?.player else { return }
        player.pause()
    }
    
    @objc func enterBackground() {
        pause()
        startButton.isSelected = false
    }
}


class KFCommonButton: UIView {
    
    var buttonAction: (() -> ())?
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "buttonBg"), for: .normal)
        button.setTitleColor(kColor(r: 0, g: 0, b: 0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "buttonSelect"))
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
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
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(36)
        }
    }
    
    var title: String? {
        didSet {
            if let title = title {
                button.setTitle(title, for: .normal)
            }
        }
    }
    
    var isSelected: Bool? {
        didSet {
            if let isSelected = isSelected {
                imageView.isHidden = !isSelected
            }
        }
    }
    
    @objc func tapAction() {
        buttonAction?()
    }
}
