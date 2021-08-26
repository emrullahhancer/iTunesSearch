//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by Emrullah Hancer on 24.08.2021.
//

import XCTest
@testable import iTunesSearch

class iTunesSearchTests: XCTestCase {
    
    private var homeViewModel: HomeViewModel!
    private var view: HomeViewController!
    
    override func setUp() {
        super.setUp()
        homeViewModel = HomeViewModel()
        view = HomeViewController()
        homeViewModel.delegate = view
        view.viewModel = homeViewModel
    }

    func testFetchData() throws {
        // Given
        let result1 = Results(collectionName: "result 1", artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Video49/v4/4d/e6/59/4de65933-40c1-60b6-ea9e-7a35e2c04dee/source/100x100bb.jpg", releaseDate: "1999-11-24T08:00:00Z", currency: "USD", longDescription: "result 1 long desc", collectionPrice: 1, trackId: 1)
        let result2 = Results(collectionName: "result 2", artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Video/v4/73/5e/d5/735ed50f-0763-5036-00d9-974d27769c9f/source/100x100bb.jpg", releaseDate: "2015-10-16T07:00:00Z", currency: "USD", longDescription: "result 2 long desc", collectionPrice: 2, trackId: 2)
        view.viewModel.results = [result1, result2]
        
        // When
        
        // Then
        XCTAssertEqual(view.viewModel.results?.count, 2)
        XCTAssertEqual(view.viewModel.results?.first?.collectionName, result1.collectionName)
    }
}
