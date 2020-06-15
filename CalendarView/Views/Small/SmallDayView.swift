// Kevin Li - 7:19 PM - 6/13/20

import SwiftUI

struct SmallDayView: View, YearlyCalendarManagerDirectAccess {

    @EnvironmentObject var calendarManager: YearlyCalendarManager

    let week: Date
    let day: Date

    private var isDayWithinDateRange: Bool {
        day >= calendar.startOfDay(for: startDate) && day <= endDate
    }

    private var isDayWithinWeekMonthAndYear: Bool {
        calendar.isDate(week, equalTo: day, toGranularities: [.month, .year])
    }

    private var isDayToday: Bool {
        calendar.isDateInToday(day)
    }

    var body: some View {
        Text(numericDay)
            .font(.system(size: 8))
            .foregroundColor(isDayToday ? .black : .white)
            .frame(width: CalendarConstants.Yearly.dayWidth, height: CalendarConstants.Yearly.dayWidth)
            .background(isDayToday ? Color.white : nil)
            .clipShape(Circle())
            .opacity(isDayWithinDateRange && isDayWithinWeekMonthAndYear ? 1 : 0)
    }

    private var numericDay: String {
        String(calendar.component(.day, from: day))
    }

}

struct SmallDayView_Previews: PreviewProvider {
    static var previews: some View {
        YearlyCalendarManagerGroup {
            DarkThemePreview {
                SmallDayView(week: Date(), day: Date())
            }

            DarkThemePreview {
                SmallDayView(week: Date(), day: .daysFromToday(3))
            }
        }
    }
}
