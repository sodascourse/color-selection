//
//  HomeViewController.swift
//  ColorSelection
//
//  Created by sodas on 12/24/16.
//  Copyright © 2016 sodastsai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ColorTableViewControllerDelegate {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var appOpenCountLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!

    let ordinaryNumberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        return numberFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAppOpenCount()

        // Register for observing notifications

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(HomeViewController.appDidFinishLaunching(_:)),
                                               name: .UIApplicationDidFinishLaunching,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(HomeViewController.appWillEnterForeground(_:)),
                                               name: .UIApplicationWillEnterForeground,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(HomeViewController.userDidSelectColor(_:)),
                                               name: .UserDidSelectColor,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Notification Handler

    func appDidFinishLaunching(_ notification: Notification) {
        self.greeting()
        self.showAppOpenCount()
    }

    func appWillEnterForeground(_ notification: Notification) {
        self.showAppOpenCount()
    }

    func userDidSelectColor(_ notification: Notification) {
        guard let colorName = notification.userInfo?["Color"] as? String else { return }
        print("notification: \(colorName)")
        self.colorLabel.text = colorName
    }

    // MARK: - Methods

    func showAppOpenCount() {
        let openCount = UserDefaults.standard.integer(forKey: .appOpenCount)
        let openCountInOrdinary = self.ordinaryNumberFormatter.string(from: (openCount as NSNumber))!
        self.appOpenCountLabel.text = "This is the \(openCountInOrdinary) time to open this app."
    }

    func greeting() {
        let alreadyLaunched = UserDefaults.standard.bool(forKey: .alreadyLaunched)
        let message: String
        if !alreadyLaunched {
            message = "Welcome! Nice to meet you."
        } else {
            message = "Hi, see you again!"
        }
        self.greetingLabel.text = message
        UserDefaults.standard.set(true, forKey: .alreadyLaunched)
    }

    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectColor" {
            guard let colorSelector = segue.destination as? ColorTableViewController else { return }
            colorSelector.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    // MARK: - Delegate of color selector

    func colorSelector(_ colorSelector: ColorTableViewController, didSelectColorNamed colorName: String) {
        print("delegate: \(colorName)")
        self.colorLabel.text = colorName
    }

}
