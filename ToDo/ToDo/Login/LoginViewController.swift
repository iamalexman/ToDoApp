//
//  LoginViewController.swift
//  ToDo
//
//  Created by Alex Smith on 22.02.2023.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
	func displaySomething(viewModel: Login.Something.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
	var interactor: LoginBusinessLogic?
	var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
	
	// MARK: Object lifecycle
	
	init() {
		super.init(nibName: nil, bundle: nil)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
//		setup()
	}
	
	// MARK: Setup
	
	private func setup() {
		let viewController = self
		let interactor = LoginInteractor()
		let presenter = LoginPresenter()
		let router = LoginRouter()
		viewController.interactor = interactor
		viewController.router = router
		interactor.presenter = presenter
		presenter.viewController = viewController
		router.viewController = viewController
		router.dataStore = interactor
	}
	
	// MARK: Routing
	
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if let scene = segue.identifier {
//			let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
//			if let router = router, router.responds(to: selector) {
//				router.perform(selector, with: segue)
//			}
//		}
//	}
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemMint
//		doSomething()
	}
	
	// MARK: Do something
	
	@IBOutlet weak var loginTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBAction func loginButtonPress(_ sender: UIButton) {
		print(#function)
	}
	
	func doSomething() {
		let request = Login.Something.Request()
		interactor?.doSomething(request: request)
	}
	
	func displaySomething(viewModel: Login.Something.ViewModel) {
		//nameTextField.text = viewModel.name
	}
}
