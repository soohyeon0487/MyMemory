//
//  ProfileVC.swift
//  MyMemory
//
//  Created by Soohyeon Lee on 2021/01/11.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let PROFILE_IMAGE_WIDTH: CGFloat = 100
    
    let uInfo = UserInfoManager()
    let profileImage = UIImageView()
    let tv = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "프로필"
        
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        self.view.addSubview(self.profileImage)
        self.view.addSubview(self.tv)
        
        let defaultProfile = self.uInfo.profile
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
        
        //로그인/로그아웃 버튼
        self.drawBtn()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:)))
        self.profileImage.addGestureRecognizer(tap)
        self.profileImage.isUserInteractionEnabled = true
    }
    
    func drawBtn() {
        
        let v = UIView()
        v.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        
        self.view.addSubview(v)
        
        let btn = UIButton(type: .system)
        v.addSubview(btn)
        
        if self.uInfo.isLogin == true {
            btn.setTitle("로그아웃", for: .normal)
            btn.addTarget(self, action: #selector(doLogout(_:)), for: .touchUpInside)
        } else {
            btn.setTitle("로그인", for: .normal)
            btn.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
        }
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        v.topAnchor.constraint(equalTo: self.tv.bottomAnchor).isActive = true
        v.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        btn.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
        btn.frame.size.width = 100
        btn.frame.size.height = 30
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
            cell.detailTextLabel?.text = self.uInfo.name ?? "Login Please"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = self.uInfo.account ?? "Login Please"
        default:
            ()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.uInfo.isLogin {
            self.doLogin(self.tv)
        }
    }
    
    @objc func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func doLogin(_ sender: Any) {
        let loginAlert = UIAlertController(title: "LOGIN", message: nil, preferredStyle: .alert)
        
        loginAlert.addTextField() {
            $0.placeholder = "Your Account"
        }
        loginAlert.addTextField() {
            $0.placeholder = "Password"
            $0.isSecureTextEntry = true
        }
        
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        loginAlert.addAction(UIAlertAction(title: "Login", style: .destructive) { _ in
            let account = loginAlert.textFields?[0].text ?? ""
            let passwd = loginAlert.textFields?[1].text ?? ""
            
            if self.uInfo.login(account: account, passwd: passwd) {
                self.tv.reloadData()
                self.profileImage.image = self.uInfo.profile
                self.drawBtn()
            } else {
                let msg = "로그인 실패"
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: false)
            }
        })
        
        self.present(loginAlert, animated: false)
    }
    
    @objc func doLogout(_ sender: Any) {
        let msg = "로그아웃 하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive) { _ in
            if self.uInfo.logout() {
                self.tv.reloadData()
                self.profileImage.image = self.uInfo.profile
                self.drawBtn()
            }
        })
        
        self.present(alert, animated: false)
    }
    
    func imgPicker(_ source: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    @objc func profile(_ sender: UIButton) {
        guard self.uInfo.account != nil else {
            self.doLogin(self)
            return
        }
        
        let alert = UIAlertController(title: nil, message: "사진을 가져올 곳을 선택해 주세요", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "카메라", style: .default) { _ in
                self.imgPicker(.camera)
            })
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            alert.addAction(UIAlertAction(title: "저장된 앨범", style: .default) { _ in
                self.imgPicker(.savedPhotosAlbum)
            })
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "포토 라이브러리", style: .default) { _ in
                self.imgPicker(.photoLibrary)
            })
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.uInfo.profile = img
            self.profileImage.image = img
        }
        
        picker.dismiss(animated: true)
    }
}
