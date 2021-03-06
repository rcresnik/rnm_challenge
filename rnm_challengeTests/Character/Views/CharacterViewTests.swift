//
//  CharacterViewTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class CharacterViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        LocalStorage.removeAllFavorites()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        LocalStorage.removeAllFavorites()
    }

    func testSetup() {
        let path = Bundle(for: type(of: self)).path(forResource: "character", ofType: "js")!
        let url = URL(fileURLWithPath: path)
        let response = try! Data(contentsOf: url)

        do {
            let character = try JSONDecoder().decode(AnimatedCharacter.self, from: response)
            let viewModel = CharacterViewModel(item: character)

            let characterView: CharacterView = UIView.loadView()
            characterView.setup(viewModel: viewModel)

            XCTAssertEqual(characterView.genderLabel.text, character.gender.rawValue)
            XCTAssertEqual(characterView.nameLabel.text, character.name)
            XCTAssertEqual(characterView.favoritesButton.title(for: .normal), CharacterViewModel.favoritesButtonTitleFor(false))
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
