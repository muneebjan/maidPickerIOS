//
//  Home_When_VC.swift
//  Maidpicker
//
//  Created by Apple on 29/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import JTAppleCalendar

class Home_When_Future_VC: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {

    @IBOutlet weak var CalenderView: JTAppleCalendarView!
    @IBOutlet weak var MonthYearLabel: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CalenderView.scrollToDate(Date(), animateScroll: false)
        CalenderView.selectDates([Date()])
        selectionViewUpdated()
        
        CalenderView.calendarDelegate = self
        CalenderView.calendarDataSource = self

        
    }
    
    func selectionViewUpdated() {
        // setup calender spacing
        CalenderView.minimumLineSpacing = 0
        CalenderView.minimumInteritemSpacing = 0
        // setup label
        
        CalenderView.visibleDates { (visibleDates) in
            self.setupViewsofCalender(from: visibleDates)
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        
        guard let validCell = view as? CustomCalenderCell else { return }
        
        let todaysDate = Date()
        formatter.dateFormat = "yyyy MM dd"
        let todaysDateString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        if todaysDateString == monthDateString{
            validCell.dateLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
        }else{
            
            if cellState.isSelected {
                validCell.dateLabel.textColor = .white
            }else{
                if(cellState.dateBelongsTo == .thisMonth){
                    validCell.dateLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                }else{
                    validCell.dateLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }
            }

        }
        
    }
    
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate = formatter.date(from: "2018 12 01")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        if let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calenderCell", for: indexPath) as? CustomCalenderCell{
            
            cell.dateLabel.text = cellState.text
            
            if cellState.isSelected{
                cell.selectedCellView.isHidden = false
            }else{
                cell.selectedCellView.isHidden = true
            }
            
            handleCellTextColor(view: cell, cellState: cellState)
            
            return cell
            
        }
        else{
            return CustomCalenderCell()
        }
    }
    // selection cell tapped
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCalenderCell else { return }
        
        if(cellState.dateBelongsTo == .thisMonth){
            validCell.selectedCellView.isHidden = false
            handleCellTextColor(view: cell, cellState: cellState)
//            print("this is DAte: \(cellState.text)")
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd"
            //print("printing current Date: \(formatter.string(from: cellState.date))")
            if(CalenderView.allowsMultipleSelection == true){
                TimeModel.TimeInstance.dateArray.append(formatter.string(from: cellState.date))
                dump(TimeModel.TimeInstance.dateArray)
            }else{
                TimeModel.TimeInstance.startDate = formatter.string(from: cellState.date)
                print("single Date: \(TimeModel.TimeInstance.startDate)")
            }
            
            
            
        }else{
            print("Outside of Current Month Date")
        }
    }
    // deSelection cell tapped
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCalenderCell else { return }
        
        validCell.selectedCellView.isHidden = true
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    
    // Scrolling function
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        //let date = visibleDates.monthDates.first?.date
        setupViewsofCalender(from: visibleDates)
    }
    
    func setupViewsofCalender(from visibleDate: DateSegmentInfo) {
        guard let date = visibleDate.monthDates.first?.date else {return}
        formatter.dateFormat = "MMMM yyyy"
        MonthYearLabel.text = formatter.string(from: date)
    }
    
    // IBAction
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print(sender.selectedSegmentIndex)
            CalenderView.deselectAllDates()
            TimeModel.TimeInstance.dateArray.removeAll()
            CalenderView.allowsMultipleSelection = false
        case 1:
            print(sender.selectedSegmentIndex)
            CalenderView.allowsMultipleSelection = true
        default:
            print("none selected")
        }
    }
    
    // Slider Functions
    
    var startSlider: Int = 0
    var endSlider: Int = 0
    var startT = ""
    var endT = ""
    
    @IBAction func startSlider(_ sender: UISlider) {
        startSlider = Int(sender.value)
        startTime.text = "\(Int(sender.value)):00"
        startT = startTime.text!
    }
    @IBAction func endSlider(_ sender: UISlider) {
        endSlider = Int(sender.value)
        endTime.text = "\(Int(sender.value)):00"
        endT = endTime.text!
    }
    
    var delegate: SliderPopupDelegate?
    @IBAction func confirmButton(_ sender: Any) {
        
        if ((startTime.text == nil) || (startTime.text == "")){
            print("please select proper date and time")
        }else{
            print("confirm button pressed")
            print(startTime.text)
            print(endTime.text)
            delegate?.confirmButtonTapped(startime: startT, endTime: endT)
            //self.performSegue(withIdentifier: "gotoHomeMain", sender: self)
        }

    }
    
// THIS FUNCTION IS NOT NECESSARY
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        if let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calenderCell", for: indexPath) as? CustomCalenderCell{
            cell.dateLabel.text = cellState.text
        }
    }
    
}

    


