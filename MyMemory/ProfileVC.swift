//
//  ProfileVC.swift
//  MyMemory
//
//  Created by Soohyeon Lee on 2021/01/11.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let PROFILE_IMAGE_WIDTH: CGFloat = 100
    
    let profileImage = UIImageView()
    let tv = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "프로필"
        
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        self.view.addSubview(self.profileImage)
        self.view.addSubview(self.tv)
        
        let defaultProfile = UIImage(systemName: "person.fill")
        self.profileImage.image = defaultProfile
        self.profileImage.tintColor = .white
        self.profileImage.backgroundColor = .black
        
        self.profileImage.layer.cornerRadius = self.PROFILE_IMAGE_WIDTH / 5
        self.profileImage.layer.borderWidth = 1.5
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.profileImage.layer.masksToBounds = true
        
        //self.profileImage.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        //self.profileImage.center = CGPoint(x: self.view.frame.width/2, y: 130)
        self.profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.profileImage.widthAnchor.constraint(equalToConstant: self.PROFILE_IMAGE_WIDTH).isActive = true
        self.profileImage.heightAnchor.constraint(equalToConstant: self.PROFILE_IMAGE_WIDTH).isActive = true
        self.profileImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.profileImage.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 130).isActive = true
        
        //self.tv.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + self.profileImage.frame.height + 20, width: self.view.frame.width, height: 100)
        self.tv.translatesAutoresizingMaskIntoConstraints = false
        self.tv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tv.topAnchor.constraint(equalTo: self.profileImage.bottomAnchor, constant: 20).isActive = true
        self.tv.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.tv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.tv.dataSource = self
        self.tv.delegate = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.font = .systemFont(ofSize: 14)
        cell.detailTextLabel?.font = .systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = "심심한 수현 씨"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = "soohyeon.lee@fake.null"
        default:
            ()
        }
        
        
        return cell
    }
    

    
    @objc func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
