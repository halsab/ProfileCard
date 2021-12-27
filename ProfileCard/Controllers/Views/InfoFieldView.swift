//
//  InfoFieldView.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import UIKit

class InfoFieldView: UIView {
  
  var icon: UIImage = UIImage() {
    didSet {
      iconImg.image = icon
    }
  }
  
  var title: String = String() {
    didSet {
      titleLbl.text = title
    }
  }
  
  private let iconImg: UIImageView = {
    let img = UIImageView()
    img.tintColor = .black
    img.contentMode = .scaleToFill
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let titleLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = .systemFont(ofSize: 22, weight: .bold)
    lbl.translatesAutoresizingMaskIntoConstraints = false
    return lbl
  }()
  
  private lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [iconImg, titleLbl])
    stack.axis = .horizontal
    stack.spacing = 8
    return stack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUp() {
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
