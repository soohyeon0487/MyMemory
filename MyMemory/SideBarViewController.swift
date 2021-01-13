//
//  SideBarViewController.swift
//  MyMemory
//
//  Created by Soohyeon Lee on 2021/01/11.
//

import UIKit

class SideBarViewController: UITableViewController {
    
    let uInfo = UserInfoManager()
    
    let titles = [
        "새 글 작성하기",
        "친구 새글",
        "달력으로 보기",
        "공지사항",
        "통계",
        "계정 관리"
    ]
    
    let icons = [
        UIImage(systemName: "pencil"),
        UIImage(systemName: "person.2.fill"),
        UIImage(systemName: "calendar"),
        UIImage(systemName: "newspaper.fill"),
        UIImage(systemName: "sum"),
        UIImage(systemName: "person.fill")
    ]
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        headerView.backgroundColor = .brown
        
        self.profileImage.tintColor = .white
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.profileImage.backgroundColor = .black
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 5
        self.profileImage.layer.borderWidth = 1.5
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.profileImage.layer.masksToBounds = true
        
        self.nameLabel.textColor = .white
        self.nameLabel.font = .boldSystemFont(ofSize: 15)
        self.nameLabel.backgroundColor = .clear
        
        self.emailLabel.textColor = .white
        self.emailLabel.font = .systemFont(ofSize: 11)
        self.emailLabel.sizeToFit()
        self.emailLabel.backgroundColor = .clear
        
        headerView.addSubview(self.profileImage)
        headerView.addSubview(self.nameLabel)
        headerView.addSubview(self.emailLabel)
        
        // SnapKit 라이브러리 쓰면 코드 정리 좋음
        
        //self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        self.profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.profileImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        self.profileImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10).isActive = true
        self.profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 70).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30)
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emailLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 70).isActive = true
        self.emailLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30).isActive = true
        self.emailLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.tableView.tableHeaderView = headerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uInfo.name ?? "Guset"
        self.emailLabel.text = self.uInfo.account ?? ""
        self.profileImage.image = self.uInfo.profile
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let id = "menucell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        cell.textLabel?.font = .systemFont(ofSize: 14)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv!, animated: true)
            self.revealViewController()?.revealToggle(self)
            
        } else if indexPath.row == 5 {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            
            uv?.modalPresentationStyle = .fullScreen
            self.present(uv!, animated: true) {
                self.revealViewController()?.revealToggle(self)
            }
        }
    }
}
