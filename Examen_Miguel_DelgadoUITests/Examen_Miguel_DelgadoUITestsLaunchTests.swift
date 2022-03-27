//
//  Examen_Miguel_DelgadoUITestsLaunchTests.swift
//  Examen_Miguel_DelgadoUITests
//
//  Created by Miguel Angel Delgado Alcantara on 09/03/22.
//

import XCTest

class Examen_Miguel_DelgadoUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
