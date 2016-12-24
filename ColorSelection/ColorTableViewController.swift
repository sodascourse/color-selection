//
//  ColorTableViewController.swift
//  ColorSelection
//
//  Created by sodas on 12/24/16.
//  Copyright © 2016 sodastsai. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let UserDidSelectColor = Notification.Name("tw.sodas.color-selection.UserDidSelectColor")
}

@objc protocol ColorTableViewControllerDelegate: NSObjectProtocol {
    @objc optional func colorSelector(_ colorSelector: ColorTableViewController,
                                      didSelectColorNamed colorName: String)
}

class ColorTableViewController: UITableViewController {

    weak var delegate: ColorTableViewControllerDelegate?

    var indexPathOfSelectedColor: IndexPath {
        get {
            let index = UserDefaults.standard.integer(forKey: .indexOfSelectedColor)
            return IndexPath(row: index, section: 0)
        }
        set {
            UserDefaults.standard.set(newValue.row, forKey: .indexOfSelectedColor)
        }
    }

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        // Show the 'checkmark' if necessary
        if indexPath == self.indexPathOfSelectedColor {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Cancel the visual style (checkmark) of previous selected cell
        if let oldCell = tableView.cellForRow(at: self.indexPathOfSelectedColor) {
            oldCell.accessoryType = .none
        }
        // Update the record
        self.indexPathOfSelectedColor = indexPath
        // Update the visual style of new selected cell
        if let newCell = tableView.cellForRow(at: self.indexPathOfSelectedColor) {
            newCell.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        // Communicate with other objects by delegate and notification pattern
        self.didSelectColor(at: indexPath.row)
    }

    // MARK: - Method

    func didSelectColor(at index: Int) {
        let colorName = self.colorName(at: index)
        // Call the delegate
        self.delegate?.colorSelector?(self, didSelectColorNamed: colorName)
        // Post notification
        let userInfo = ["Color": colorName]
        let notification = Notification(name: .UserDidSelectColor, object: self, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }

    func colorName(at index: Int) -> String {
        switch index {
        case 0:
            return "Red"
        case 1:
            return "Green"
        case 2:
            return "Blue"
        default:
            fatalError()
        }
    }

}
