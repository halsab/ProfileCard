//
//  UserProfileVC.swift
//  ProfileCard
//
//  Created by Ha Sab on 27.12.2021.
//

import UIKit

class UserProfileVC: UIViewController {
  
  private var userProfileViewModel: UserProfileViewModel? {
    willSet {
      userProfileViewModel?.onDataUpdate = nil
    }
    didSet {
      userProfileViewModel?.onDataUpdate = { [weak self] in
        guard let viewModel = self?.userProfileViewModel else { return }
        self?.updateData(by: viewModel)
      }
    }
  }
  
  private struct Constants {
    static let imageSize = CGSize(width: 160, height: 160)
  }
  
  private let userImg: UIImageView = {
    let img = UIImageView()
    img.backgroundColor = .white
    img.layer.cornerRadius = 20
    img.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
    img.layer.borderWidth = 1
    img.clipsToBounds = true
    img.contentMode = .scaleAspectFill
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let firstNameLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = .systemFont(ofSize: 26, weight: .bold)
    return lbl
  }()
  
  private let lastNameLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = .systemFont(ofSize: 26, weight: .bold)
    return lbl
  }()
  
  private lazy var nameStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [firstNameLbl, lastNameLbl])
    stack.alignment = .center
    stack.axis = .vertical
    stack.spacing = 8
    stack.clipsToBounds = true
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private let emailView: InfoFieldView = {
    let view = InfoFieldView()
    view.icon = UIImage(systemName: "mail") ?? UIImage()
    return view
  }()
  
  private let cellView: InfoFieldView = {
    let view = InfoFieldView()
    view.icon = UIImage(systemName: "phone.circle") ?? UIImage()
    return view
  }()
  
  private let locationView: InfoFieldView = {
    let view = InfoFieldView()
    view.icon = UIImage(systemName: "network") ?? UIImage()
    return view
  }()
  
  private lazy var infoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [emailView, cellView, locationView])
    stack.axis = .vertical
    stack.spacing = 12
    stack.clipsToBounds = true
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private let headerColoredView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private var someColors: [UIColor] = [.systemBlue, .systemPink, .systemRed, .systemGreen, .systemOrange]

  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    setUpViewModel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    headerColoredView.backgroundColor = someColors.shuffled().first?.withAlphaComponent(0.5)
  }
  
  private func setUp() {
    view.backgroundColor = .white
    
    view.addSubview(headerColoredView)
    view.addSubview(userImg)
    view.addSubview(nameStackView)
    view.addSubview(infoStackView)

    NSLayoutConstraint.activate([
      headerColoredView.topAnchor.constraint(equalTo: view.topAnchor),
      headerColoredView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerColoredView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerColoredView.bottomAnchor.constraint(equalTo: userImg.centerYAnchor),
      
      userImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      userImg.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      userImg.heightAnchor.constraint(equalToConstant: Constants.imageSize.height),
      userImg.widthAnchor.constraint(equalToConstant: Constants.imageSize.width),
      
      nameStackView.topAnchor.constraint(equalTo: userImg.bottomAnchor, constant: 40),
      nameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      nameStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
      infoStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 40),
      infoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
      infoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
    ])
  }
  
  private func setUpViewModel() {
    userProfileViewModel = UserProfileViewModel()
    userProfileViewModel?.updateUserData()
  }
  
  private func updateData(by viewModel: UserProfileViewModel) {
    firstNameLbl.text = viewModel.firstName
    lastNameLbl.text = viewModel.lastName
    
    emailView.title = viewModel.email
    cellView.title = viewModel.cell
    locationView.title = viewModel.location
    
    APIService.downloadImage(from: viewModel.imageStringUrl) { image in
      DispatchQueue.main.async() { [weak self] in
        self?.userImg.image = image
      }
    }
  }
}

