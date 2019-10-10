//
//  CustomControl.swift
//  Star Rating
//
//  Created by Percy Ngan on 10/10/19.
//  Copyright © 2019 Lamdba School. All rights reserved.
//

import Foundation
import UIKit

class CustomControl: UIControl {

	// What does this mean that this is API facing
	var value: Int = 1
	private let componentDimension: CGFloat = 40.0
	private let componentCount = 5
	private let componentActiveColor: UIColor = .black
	private let componentInactiveColor: UIColor = .gray
	private var components: [UILabel] = []

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupStars()
	}

	required init?(coder aCoder: NSCoder) {
		super.init(coder: aCoder)
		setupStars()

	}

	func setupStars() {

		for i in 1...5 {

			let label = UILabel()
			let spacing: Int = 8
			//let star = "\u{2729}"
			addSubview(label)
			components.append(label)
			label.tag = i
			label.font = UIFont.boldSystemFont(ofSize: 32)
			label.text = "✮"
			label.textAlignment = .center

			let offset = CGFloat(i - 1) * componentDimension + CGFloat(i) * 8.0
			let origin = CGPoint(x: offset, y: 0)
			let starSize = CGSize(width: componentDimension, height: componentDimension)
			label.frame = CGRect(origin: origin, size: starSize)

//			if label.tag > 1 {
//				label.frame = CGRect(x: componentDimension + CGFloat(i * spacing), y: bounds.midY, width: componentDimension, height: componentDimension)
//			} else {
//				label.frame = CGRect(x: 8.0, y: bounds.midY, width: componentDimension, height: componentDimension)
//			}

		}
	}

	override var intrinsicContentSize: CGSize {
		let componentsWidth = CGFloat(componentCount) * componentDimension
		let componentsSpacing = CGFloat(componentCount + 1) * 8.0
		let width = componentsWidth + componentsSpacing
		return CGSize(width: width, height: componentDimension)
	}

	// MARK: - Touch Tracking
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

		let touchPoint = touch.location(in: self)

		if bounds.contains(touchPoint) {
			selectedColor = colorWheel.color(for: touchPoint)
			sendActions(for: .valueChanged)
		}
		sendActions(for: .touchDown)
		return true
	}


	override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

		let touchPoint = touch.location(in: self)

		if bounds.contains(touchPoint) {
			selectedColor = colorWheel.color(for: touchPoint)
			sendActions(for: [.valueChanged, .touchDragInside])
		} else {
			sendActions(for: .touchDragOutside)
		}

		print(touchPoint)
		return true
	}

	override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		super.endTracking(touch, with: event)

		guard let touch = touch else { return }

		let touchPoint = touch.location(in: self)

		if bounds.contains(touchPoint) {

			selectedColor = colorWheel.color(for: touchPoint)
			sendActions(for: [.valueChanged, .touchDragInside])
		} else {
			sendActions(for: .touchUpOutside)
		}
	}

	// Only gets call when an outside action gets called
	override func cancelTracking(with event: UIEvent?) {
		sendActions(for: .touchCancel)
	}

}
