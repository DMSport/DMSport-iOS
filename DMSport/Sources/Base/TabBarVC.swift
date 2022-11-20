import UIKit
import RxSwift
import RxCocoa
import RxFlow

class TabBarVC: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTabBarLayout()
        setUpTabBarItem()
    }

    func setUpTabBarLayout() {
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = DMSportIOSColors.Color(named: "WhiteColor")
        tabBar.unselectedItemTintColor = DMSportIOSColors.Color(named: "SubtitleColor")
        tabBar.tintColor = DMSportIOSColors.Color(named: "MainColor")
        self.hidesBottomBarWhenPushed = true
    }

    func setUpTabBarItem() {
        let voteVC = VoteVC()
        voteVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Vote_dark"),
            selectedImage: UIImage(named: "Vote_bright")
        )
        let noticeVC = NoticeVC()
        noticeVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Megaphone_dark"),
            selectedImage: UIImage(named: "Megaphone_bright")
        )
        
        viewControllers = [
            voteVC,
            noticeVC
        ]
    }
}
