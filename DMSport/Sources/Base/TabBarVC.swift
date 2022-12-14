import UIKit
import RxSwift
import RxCocoa
import RxFlow

class TabBarVC: UITabBarController {
    typealias DMSportColor = DMSportIOSAsset.Color
    typealias DMSportImage = DMSportIOSAsset.Assets
    
    override func viewWillAppear(_ animated: Bool) {
        if Token.accessToken == "" {
            let loginVC = BaseNC(rootViewController: LoginViewController())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false)
        }
        super.viewWillAppear(animated)
        setUpTabBarLayout()
        setUpTabBarItem()
    }
    
    func setUpTabBarLayout() {
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = DMSportColor.whiteColor.color
        tabBar.unselectedItemTintColor = DMSportColor.subtitleColor.color
        tabBar.tintColor = DMSportColor.mainColor.color
        self.hidesBottomBarWhenPushed = true
        self.tabBar.layer.cornerRadius = 20
    }
    
    func setUpTabBarItem() {
        let voteVC = VoteVC()
        voteVC.tabBarItem = UITabBarItem(
            title: "",
            image: DMSportImage.voteDark.image,
            selectedImage: DMSportImage.voteBright.image
        )
        let noticeVC = NoticeVC()
        noticeVC.tabBarItem = UITabBarItem(
            title: "",
            image: DMSportImage.megaphoneDark.image,
            selectedImage: DMSportImage.megaphoneBright.image
        )
        let myPageVC = MyPageViewController()
        myPageVC.tabBarItem = UITabBarItem(
            title: "",
            image: DMSportImage.personDark.image,
            selectedImage: DMSportImage.personBright.image)
        
        viewControllers = [
            voteVC,
            noticeVC,
            myPageVC
        ]
    }
}
