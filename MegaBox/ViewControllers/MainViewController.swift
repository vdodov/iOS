//
//  ViewController.swift
//  MegaBox
//
//  Created by Fury on 18/07/2019.
//  Copyright © 2019 Fury. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  private var isTop: Bool = true
  
  private let mainTopView = MainTopView()
  private let mainTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(MainTopMediaPlayCell.self, forCellReuseIdentifier: MainTopMediaPlayCell.identifier)
    tableView.register(MainMovieReservationCell.self, forCellReuseIdentifier: MainMovieReservationCell.identifier)
    tableView.register(MainShortMenuCell.self, forCellReuseIdentifier: MainShortMenuCell.identifier)
    tableView.register(MainAdCell.self, forCellReuseIdentifier: MainAdCell.identifier)
    tableView.register(MainEventCell.self, forCellReuseIdentifier: MainEventCell.identifier)
    tableView.register(MainMovieBoxCell.self, forCellReuseIdentifier: MainMovieBoxCell.identifier)
    tableView.register(MainMoviePostCell.self, forCellReuseIdentifier: MainMoviePostCell.identifier)
    tableView.register(MainBranchNewsCell.self, forCellReuseIdentifier: MainBranchNewsCell.identifier)
    tableView.register(MainNotificationCell.self, forCellReuseIdentifier: MainNotificationCell.identifier)
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    self.mainTableView.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0.8392156863, blue: 0.862745098, alpha: 1)
    self.mainTableView.showsVerticalScrollIndicator = false
    self.mainTableView.separatorColor = UIColor.clear
    self.mainTableView.allowsSelection = false
    
    self.mainTableView.dataSource = self
    self.mainTableView.delegate = self
    self.mainTopView.delegate = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupMainTopView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let movieReservationCell = mainTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? MainMovieReservationCell
    
    movieReservationCell?.movieReservationCollection.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
  }
  
  private func setupMainTopView() {
    mainTopView.translatesAutoresizingMaskIntoConstraints = false
    mainTableView.translatesAutoresizingMaskIntoConstraints = false
    
    let guide = view.safeAreaLayoutGuide
    
    view.addSubview(mainTableView)
    mainTableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    mainTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    mainTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    mainTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    
    mainTableView.addSubview(mainTopView)
    mainTopView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    mainTopView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    mainTopView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    mainTopView.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
}

// MARK:- 수정이 필요한 사항
// 뷰 띄우는 행위 컨트롤러로 이동기킬 것
extension MainViewController: MainTopViewDelegate {
  func openNavigationDrawerView() {
    let navigationDrawerVC = NavigationDrawerViewController()
    self.present(navigationDrawerVC, animated: false)
  }
  
  func openQuickReservationView() {
    let quickReservationVC = QuickReservationViewController()
    quickReservationVC.modalPresentationStyle = .overCurrentContext
    self.present(quickReservationVC, animated: false)
  }
}

extension MainViewController: MainMovieReservationCellDelegate {
  func touchUpReservationOwlStageButton(_ sender: UIButton, _ trailing: NSLayoutConstraint, _ leading: NSLayoutConstraint, _ stackViewWidth: CGFloat) {
    // +-20은 StackView의 Spacing
    leading.constant = sender.frame.minX + 20
    trailing.constant = -(stackViewWidth - sender.frame.maxX - 20)
    self.view.layoutIfNeeded()
  }
}

extension MainViewController: MainEventCellDelegate {
  func touchUpEventOwlStageButton(_ sender: UIButton, _ trailing: NSLayoutConstraint, _ leading:
    NSLayoutConstraint, _ stackViewWidth: CGFloat) {
    
    leading.constant = sender.frame.minX + 20
    trailing.constant = -(stackViewWidth - sender.frame.maxX - 20)
    self.view.layoutIfNeeded()
  }
}

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 11
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MainTopMediaPlayCell.identifier) as! MainTopMediaPlayCell
    
    if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainMovieReservationCell.identifier) as! MainMovieReservationCell
      // Owl Stage Button Click Delegate
      return cell
    } else if indexPath.row == 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainShortMenuCell.identifier) as! MainShortMenuCell
      return cell
    } else if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainAdCell.identifier) as! MainAdCell
      guard let adImageNum: Int = (0...1).randomElement() else { return cell }
      let adImageArr: [UIImage] = [#imageLiteral(resourceName: "ad1"), #imageLiteral(resourceName: "ad2")]
      if adImageNum == 0 {
        cell.guideBGView.backgroundColor = #colorLiteral(red: 1, green: 0.9568627451, blue: 0.9647058824, alpha: 1)
      } else {
        cell.guideBGView.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0.2745098039, blue: 0.8431372549, alpha: 1)
      }
      cell.adImage.image = adImageArr[adImageNum]
      return cell
    } else if indexPath.row == 4 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainEventCell.identifier) as! MainEventCell
      // Owl Stage Button Click Delegate
      cell.delegate = self
      return cell
    } else if indexPath.row == 5 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainMovieBoxCell.identifier) as! MainMovieBoxCell
      return cell
    } else if indexPath.row == 6 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainAdCell.identifier) as! MainAdCell
      guard let adImageNum: Int = (0...1).randomElement() else { return cell }
      let adImageArr: [UIImage] = [#imageLiteral(resourceName: "ad4"), #imageLiteral(resourceName: "ad3")]
      if adImageNum == 0 {
        cell.guideBGView.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1333333333, blue: 0.137254902, alpha: 1)
      } else {
        cell.guideBGView.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.2, blue: 0.5450980392, alpha: 1)
      }
      cell.adImage.image = adImageArr[adImageNum]
      return cell
    } else if indexPath.row == 7 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainMoviePostCell.identifier) as! MainMoviePostCell
      return cell
    } else if indexPath.row == 8 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainBranchNewsCell.identifier) as! MainBranchNewsCell
      return cell
    } else if indexPath.row == 9 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainNotificationCell.identifier) as! MainNotificationCell
      return cell
    } else if indexPath.row == 10 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MainAdCell.identifier) as! MainAdCell
      guard let adImageNum: Int = (0...1).randomElement() else { return cell }
      let adImageArr: [UIImage] = [#imageLiteral(resourceName: "ad4"), #imageLiteral(resourceName: "ad3")]
      if adImageNum == 0 {
        cell.guideBGView.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1333333333, blue: 0.137254902, alpha: 1)
      } else {
        cell.guideBGView.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.2, blue: 0.5450980392, alpha: 1)
      }
      cell.adImage.image = adImageArr[adImageNum]
      return cell
    }
    
    return cell
  }
}

extension MainViewController: UITableViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // 해더뷰 고정 해제
    let scrollHeaderHeight = ((UIScreen.main .bounds.width * 907) / 1080) + 10
    if scrollView.contentOffset.y >= scrollHeaderHeight {
      if isTop == false {
        return
      }
      mainTopView.topMediaVisualTopView.layer.borderWidth = 0.5
      mainTopView.titleImage.image = #imageLiteral(resourceName: "main_top_logo_purple")
      mainTopView.quickReservationButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      mainTopView.quickReservationButton.backgroundColor = UIColor.appColor(.megaBoxColor)
      mainTopView.quickReservationButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
      mainTopView.topMediaVisualTopView.alpha = 1
      mainTopView.topMediaVisualTopView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      mainTopView.hamburgerMenu.setImage(#imageLiteral(resourceName: "main_top_menu_gray_btn"), for: .normal)
      isTop.toggle()
    } else {
      if isTop == true {
        return
      }
      mainTopView.topMediaVisualTopView.layer.borderWidth = 0
      mainTopView.titleImage.image = #imageLiteral(resourceName: "main_top_logo_white")
      mainTopView.quickReservationButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      mainTopView.quickReservationButton.backgroundColor = .clear
      mainTopView.quickReservationButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
      mainTopView.topMediaVisualTopView.alpha = 0.3
      mainTopView.topMediaVisualTopView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      mainTopView.hamburgerMenu.setImage(#imageLiteral(resourceName: "main_top_menu_white_btn"), for: .normal)
      isTop.toggle()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return (UIScreen.main.bounds.width * 907) / 1080
    } else if indexPath.row == 1 {
      // 영화예매
      return 430
    } else if indexPath.row == 2 {
      // Short메뉴
      return 90
    } else if indexPath.row == 3 {
      // 광고
      return 90
    } else if indexPath.row == 4 {
      // 이벤트
      return 380
    } else if indexPath.row == 5 {
      // 무비박스
      return ((UIScreen.main.bounds.width - 20) * 460) / 708
    } else if indexPath.row == 6 {
      // 광고
      return 90
    } else if indexPath.row == 7 {
      // 무비포스트
      return 430
    } else if indexPath.row == 8 {
      // 지점소식
      return ((UIScreen.main.bounds.width) * 460) / 750
    } else if indexPath.row == 9 {
      // 공지사항
      return 130
    } else if indexPath.row == 10 {
      // 광고
      return 90
    }
    return 80
  }
}
