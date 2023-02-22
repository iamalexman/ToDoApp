//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Alex Smith on 18.02.2023.
//

import UIKit

final class ToDoTableViewController: UITableViewController {
	
	var presenter: IToDoViewPresenter!

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "ToDoList"
		presenter.showToDoList()
	}
	
	private func getTaskForIndex(_ indexPath: IndexPath) -> TaskViewModel {
		presenter.getTasksForSections(section: indexPath.section)[indexPath.row]
	}
	
	// MARK: - Table view data source
	override func numberOfSections(in tableView: UITableView) -> Int {
		presenter.getSectionsTitles().count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presenter.getTasksForSections(section: section).count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = getTaskForIndex(indexPath)
		let cell = UITableViewCell()
		var contentConfig = cell.defaultContentConfiguration()
		
		if task.isImportantTask {
			let priorityText = "\(task.priorityTag ?? "")"
			let text = "\(priorityText) \(task.title)"
			let range = (text as NSString).range(of: priorityText)
			let mutableAttributedString = NSMutableAttributedString(string: text)
			mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
			
			contentConfig.attributedText = mutableAttributedString
			contentConfig.secondaryText = "Deadline: " + task.deadline
			contentConfig.textProperties.color = .label
		} else {
			contentConfig.text = task.title
		}
		
		contentConfig.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfig.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.backgroundColor = task.isExpired ? .systemPink.withAlphaComponent(0.2) : .systemBackground
		cell.tintColor = .systemGray3
		cell.selectionStyle = .none
		cell.contentConfiguration = contentConfig
		cell.accessoryType = task.isCompleted ? .checkmark : .none
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		presenter.getSectionsTitles()[section]
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.checkTask(section: indexPath.section, index: indexPath.row)
		tableView.reloadData()
	}
}

extension ToDoTableViewController: IToDoView {
	func render(viewData: ViewData) { }
}
