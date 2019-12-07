//
//  TimerCollectionViewCell.swift
//  Final_project
//
//  Created by evanlou on 11/7/19.
//  Copyright © 2019 evanlou. All rights reserved.
//

import UIKit

protocol EditDelegate: class {
    func didSelectEdit(isEdit: Bool)
}


class TimerCollectionViewCell: UICollectionViewCell {
    var title: UILabel!
    var time: UILabel!
    var timeViewBtn: UIButton!
    var trashImageView: UIImageView!
    weak var editDelegate: EditDelegate?
    
    var mTimer: TimerData
    weak var parentViewController: UIViewController?
    
    let backgoundImage = ["iphone_x_wallpaper.jpg", "image1.jpg", "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg"]
    
    override init(frame: CGRect) {
        mTimer = TimerData(backgroundImage: "", duration: "", title: "")
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = ""
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 20)
        title.textAlignment = .center
        title.sizeToFit()
        contentView.addSubview(title)
        
        time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.text = ""
        time.textColor = .white
        time.font = UIFont.systemFont(ofSize: 14)
        time.textAlignment = .center
        time.sizeToFit()
        contentView.addSubview(time)
        
        timeViewBtn = UIButton()
        timeViewBtn.translatesAutoresizingMaskIntoConstraints = false
        timeViewBtn.setTitle("Start", for: .normal)
        timeViewBtn.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        timeViewBtn.setTitleColor(.white, for: .normal)
        timeViewBtn.sizeToFit()
        timeViewBtn.addTarget(self, action: #selector(changeTimerView), for: .touchUpInside)
        contentView.addSubview(timeViewBtn)
        
        trashImageView = UIImageView(image: UIImage(named: "first"))
        trashImageView.backgroundColor = .white
        trashImageView.contentMode = .scaleAspectFit
        trashImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trashImageView)
        
        
       setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            title.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            title.heightAnchor.constraint(equalToConstant: 20)
        ]);
        NSLayoutConstraint.activate([
            time.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            time.widthAnchor.constraint(equalToConstant: 50),
            time.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            time.heightAnchor.constraint(equalToConstant: 14)
        ]);
        NSLayoutConstraint.activate([
            timeViewBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeViewBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            timeViewBtn.heightAnchor.constraint(equalToConstant: 22),
            timeViewBtn.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        ]);
        
        NSLayoutConstraint.activate([
            trashImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trashImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            trashImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            trashImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])

    }
    
    @objc func changeTimerView() {
        let background = backgoundImage.randomElement()!
        let timerView = TimerViewController(image: background, duration: mTimer.duration)
        timerView.modalPresentationStyle = .fullScreen
        parentViewController?.present(timerView, animated: true, completion: nil)
    }
    
    func configureForView(for timer: TimerData) {
        mTimer = timer
        title.text = timer.title
        time.text = timer.duration + " min"
        trashImageView.isHidden = true
        timeViewBtn.isHidden = false
        contentView.layer.mask = nil
        contentView.backgroundColor =  UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
    }
    
    
    func configureForEdit(for timer: TimerData) {
    }
    
    func addSelectedEffect(){
        let mask = CALayer()
        mask.frame = bounds
        let whiteMask = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        mask.backgroundColor = whiteMask.cgColor
        contentView.layer.mask = mask
    }
    
    func removeSelectedEffect(){
        contentView.layer.mask = nil
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let timerSetup = TimerSetupViewController(currentCell: self)
//        self.isSelected = true
//        timerSetup.delegateDelete?.timerDelete()
//        timerSetup.delegate = self
//        parentViewController.present(timerSetup, animated: true, completion: nil)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TimerCollectionViewCell: TimerSetupDelegate {
    func timerSetup(newTitle: String, newDuration: String) {
        title.text = newTitle
        time.text = newDuration
    }
}

//extension UIView {
//    func setBackgroundCell() {
//        let width = UIScreen.main.bounds.size.width
//        let height = UIScreen.main.bounds.size.height
//
//        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        imageViewBackground.image = UIImage(named: "iphone_x_wallpaper.jpg")
//
//        // you can change the content mode:
//        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
//
//        self.addSubview(imageViewBackground)
//        self.sendSubviewToBack(imageViewBackground)
//    }
//}
