//
//  LoginPresenter.swift
//  ToDo
//
//  Created by Alex Smith on 22.02.2023.
//

import UIKit

protocol LoginPresentationLogic {
	func presentSomething(response: Login.Something.Response)
}

class LoginPresenter: LoginPresentationLogic {
	weak var viewController: LoginDisplayLogic?
	
	// MARK: Do something
	
	func presentSomething(response: Login.Something.Response) {
		let viewModel = Login.Something.ViewModel()
		viewController?.displaySomething(viewModel: viewModel)
	}
}
