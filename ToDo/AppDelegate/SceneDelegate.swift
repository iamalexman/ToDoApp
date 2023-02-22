//
//  SceneDelegate.swift
//  ToDo
//
//  Created by Alex Smith on 11.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	
	func scene(_ scene: UIScene,
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		
//		let toDoModule = ToDoModuleBuilder.build()
		let loginModule = LoginViewController()
		
//		let navigation = UINavigationController(rootViewController: toDoModule)
		let navigation = UINavigationController(rootViewController: loginModule)
		let appearance = UINavigationBarAppearance()

		navigation.navigationBar.scrollEdgeAppearance = appearance
		appearance.backgroundColor = .lightGray

//		window.rootViewController = navigation
		window.rootViewController = loginModule
		window.makeKeyAndVisible()
		self.window = window
	}

	func sceneDidDisconnect(_ scene: UIScene) { }

	func sceneDidBecomeActive(_ scene: UIScene) { }

	func sceneWillResignActive(_ scene: UIScene) { }

	func sceneWillEnterForeground(_ scene: UIScene) { }

	func sceneDidEnterBackground(_ scene: UIScene) { }
}

