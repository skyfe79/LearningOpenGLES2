import Foundation

// MARK: - Components

public extension Date {
  
  public static var tomorrow: Date {return TimeInterval(1).day.later }
  public static var now: Date { return TimeInterval(0).day.ago }
  public static var yesterday: Date { return TimeInterval(1).day.ago }
  
  public func components(_ unit: NSCalendar.Unit,
                         retrieval: (DateComponents) -> Int) -> Int {
    let calendar = Calendar.current
    let components = (calendar as NSCalendar).components(unit, from: self)
    
    return retrieval(components)
  }
  
  public var second: Int {
    return components(.second) {
      return $0.second ?? 0
    }
  }
  
  public var minute: Int {
    return components(.minute) {
      return $0.minute ?? 0
    }
  }
  
  public var hour: Int {
    return components(.hour) {
      return $0.hour ?? 0
    }
  }
  
  public var day: Int {
    return components(.day) {
      return $0.day ?? 0
    }
  }
  
  public var month: Int {
    return components(.month) {
      return $0.month ?? 0
    }
  }
  
  public var year: Int {
    return components(.year) {
      return $0.year ?? 0
    }
  }
  
  public var weekday: Int {
    return components(.weekday) {
      return $0.weekday ?? 0
    }
  }
}

public extension Date {
  public func to(_ format: DateFormat) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }
}

public extension String {
  public func to(_ format: DateFormat) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.date(from: self)
  }
}



















