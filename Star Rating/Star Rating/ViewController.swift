//
//  ViewController.swift
//  Star Rating
//
//  Created by Percy Ngan on 10/10/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let customControl: CustomControl?

	override func viewDidLoad() {
		super.viewDidLoad()

		// Set the code to show star for 1 star and stars for >1
		title = "User Rating: \(customControl?.value) stars"
	}

	@IBAction func updateRating(_ ratingControl: CustomControl) {

		

	}

}

