//
//  InfoFieldView.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import UIKit

class InfoFieldView: UIView {
  
  // MARK: - Views
  
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
  
  private struct Constants {
    static let imageSize = CGSize(width: 24, height: 24)
  }
  
  private let iconImg: UIImageView = {
    let img = UIImageView()
    img.tintColor = .black
    img.contentMode = .scaleAspectFit
    return img
  }()
  
  private let titleLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = .systemFont(ofSize: 16, weight: .semibold)
    lbl.numberOfLines = 2
    return lbl
  }()
  
  private lazy var infoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [iconImg, titleLbl])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.clipsToBounds = true
    return stack
  }()
  
  private let lineView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    return view
  }()
  
  private lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [infoStackView, lineView])
    stack.axis = .vertical
    stack.spacing = 8
    stack.clipsToBounds = true
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Set Up
  
  private func setUp() {
    addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      lineView.heightAnchor.constraint(equalToConstant: 1),
      
      iconImg.widthAnchor.constraint(equalToConstant: Constants.imageSize.width),
    ])
  }
}
