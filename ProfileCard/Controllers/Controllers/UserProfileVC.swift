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
  
  private let userImg: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleToFill
    img.translatesAutoresizingMaskIntoConstraints = false
    return img
  }()
  
  private let firstNameLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = .systemFont(ofSize: 22, weight: .bold)
    return lbl
  }()
  
  private let lastNameLbl: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = .systemFont(ofSize: 22, weight: .bold)
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
    view.icon = UIImage(systemName: "mail.fill") ?? UIImage()
    return view
  }()
  
  private let cellView: InfoFieldView = {
    let view = InfoFieldView()
    view.icon = UIImage(systemName: "phone.circle.fill") ?? UIImage()
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
    stack.spacing = 8
    stack.clipsToBounds = true
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    setUpViewModel()
  }
  
  private func setUp() {
    view.backgroundColor = .white
    
    view.addSubview(nameStackView)
    view.addSubview(infoStackView)

    NSLayoutConstraint.activate([
      nameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      nameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      nameStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
      infoStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 20),
      infoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      infoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
    ])
  }
  
  private func setUpViewModel() {
    userProfileViewModel = UserProfileViewModel()
  }
  
  private func updateData(by viewModel: UserProfileViewModel) {
    firstNameLbl.text = viewModel.firstName
    lastNameLbl.text = viewModel.lastName
    
    emailView.title = viewModel.email
    cellView.title = viewModel.cell
    locationView.title = viewModel.location
  }
}

