//
//  SearchTrainPresenterTests.swift
//  MyTravelHelperTests
//
//  Created by Satish on 11/03/19.
//  Copyright © 2019 Sample. All rights reserved.
//

import XCTest
@testable import MyTravelHelper

class SearchTrainPresenterTests: XCTestCase {
    var presenter: SearchTrainPresenter!
    var view = SearchTrainMockView()
    var interactor = SearchTrainInteractorMock()
    
    override func setUp() {
      presenter = SearchTrainPresenter()
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
    }

    func testfetchallStations() {
        presenter.fetchallStations()

        XCTAssertTrue(view.isSaveFetchedStatinsCalled)
    }

    override func tearDown() {
        presenter = nil
    }
    
}


class SearchTrainMockView:PresenterToViewProtocol {
    var isSaveFetchedStatinsCalled = false

    func saveFetchedStations(stations: [Station]?) {
        isSaveFetchedStatinsCalled = true
    }

    func showInvalidSourceOrDestinationAlert() {

    }
    
    func updateLatestTrainList(trainsList: [StationTrain]) {

    }
    
    func showNoTrainsFoundAlert() {

    }
    
    func showNoTrainAvailbilityFromSource() {

    }
    
    func showNoInterNetAvailabilityMessage() {

    }
}

class SearchTrainInteractorMock:PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?

    func fetchallStations() {
        let station = Station(desc: "Belfast Central", latitude: 54.6123, longitude: -5.91744, code: "BFSTC", stationId: 228)
        presenter?.stationListFetched(list: [station])
    }

    func fetchTrainsFromSource(sourceCode: String, destinationCode: String) {

    }
    
    private func proceesTrainListforDestinationCheck(trainsList: [StationTrain]) {
        var _trainsList = trainsList
        let today = Date()
        let group = DispatchGroup()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: today)
        
            group.enter()
            let response = TrainMovementsData(trainMovements: [TrainMovement(trainCode: "A182", locationCode: "4637", locationFullName: "Aftan", expDeparture: "12.22"), TrainMovement(trainCode: "A182", locationCode: "4637", locationFullName: "Aftan", expDeparture: "12.22"), TrainMovement(trainCode: "A182", locationCode: "4637", locationFullName: "Aftan", expDeparture: "12.22"), TrainMovement(trainCode: "A182", locationCode: "4637", locationFullName: "Aftan", expDeparture: "12.22"), TrainMovement(trainCode: "A182", locationCode: "4637", locationFullName: "Aftan", expDeparture: "12.22")])
            group.leave()


        group.notify(queue: DispatchQueue.main) {
            let sourceToDestinationTrains = _trainsList
            self.presenter!.fetchedTrainsList(trainsList: sourceToDestinationTrains)
        }
    }
}
