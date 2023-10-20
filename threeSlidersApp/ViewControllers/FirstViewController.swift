//
//  FirstViewController.swift
//  threeSlidersApp
//
//  Created by Roman on 20.10.23.
//

import UIKit

final class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController  else { return }
        settingsVC.forBackgroundcolor = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension FirstViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
}
