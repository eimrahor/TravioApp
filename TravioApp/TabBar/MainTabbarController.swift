//
//  MainTabbarController.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.258569181, green: 0.7276339531, blue: 0.7204007506, alpha: 1)
        
        let appearance = UITabBar.appearance()
        
        appearance.tintColor = #colorLiteral(red: 0.258569181, green: 0.7276339531, blue: 0.7204007506, alpha: 1)
        appearance.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let vc1 = HomeVC()
        let image = UIImage(systemName: "house")
        let selectedImage = UIImage(systemName: "house.fill")
        vc1.tabBarItem = UITabBarItem(title: "Home", image: image, selectedImage: selectedImage)
        
        let vc2 = VisitsVC()
        //let nav2 = UINavigationController(rootViewController: vc2)
        let image2 = UIImage(named: "location")
        
        let newSize2 = CGSize(width: 30, height: 30)
        let resizedImage2 = image2!.resized(to: newSize2)
        
        let selectedImage2 = UIImage(named: "map")
        let selectedNewSize2 = CGSize(width: 30, height: 30)
        let selectedresizedImage2 = selectedImage2!.resized(to: selectedNewSize2)
        vc2.tabBarItem = UITabBarItem(title: "Visits", image: resizedImage2, selectedImage: selectedresizedImage2)
        vc2.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: 3, right: 0)
        
        
        let vc3 = MapVC()
        let image3 = UIImage(systemName: "map")
        let selectedImage3 = UIImage(systemName: "map.fill")
        vc3.tabBarItem = UITabBarItem(title: "Map", image: image3, selectedImage: selectedImage3)
        
        
        let vc4 = MenuVC()
        let image4 = UIImage(named: "menuemp")
        let newSize4 = CGSize(width: 30, height: 30)
        let resizedImage4 = image4!.resized(to: newSize4)
        let selectedImage4 = UIImage(named: "menu")
        let selectedNewSize4 = CGSize(width: 30, height: 30)
        let selectedresizedImage4 = selectedImage4!.resized(to: selectedNewSize4)
        vc4.tabBarItem = UITabBarItem(title: "Menu", image: resizedImage4, selectedImage: selectedresizedImage4)
        vc4.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: 3, right: 0)
        
        
        self.viewControllers = [vc1,vc2,vc3,vc4]
        self.selectedIndex = 1
    }
    

}
