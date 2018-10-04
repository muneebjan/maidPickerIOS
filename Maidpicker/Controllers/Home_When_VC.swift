//
//  Home_When_VC.swift
//  Maidpicker
//
//  Created by Apple on 29/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import JTAppleCalendar

class Home_When_VC: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {

    let formatter = DateFormatter()
    
    @IBOutlet weak var CalenderView: JTAppleCalendarView!
    @IBOutlet weak var MonthYearLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
// THIS FUNCTION IS NOT NECESSARY
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        if let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calenderCell", for: indexPath) as? CustomCalenderCell{
            cell.dateLabel.text = cellState.text
            
        }
    }
}

    


