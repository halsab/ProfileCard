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
    stack.axis = .vertical
    stack.spacing = 8
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

    NSLayoutConstraint.activate([
      nameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      nameStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      nameStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
  }
  
  private func setUpViewModel() {
    userProfileViewModel = UserProfileViewModel()
  }
  
  private func updateData(by viewModel: UserProfileViewModel) {
    firstNameLbl.text = viewModel.firstName
    lastNameLbl.text = viewModel.lastName
  }
}
