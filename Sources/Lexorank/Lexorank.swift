/// Store order by indefinite spacing inbetween string concatenation.
/// Padd the shorter string to comodate for an theoretical infinite amount of strings to order by.

final class LexoRank {
  let orderToByte  = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  let minChar = byteToOrder(Character("0").asciiValue!)!
  let maxChar = byteToOrder(Character("z").asciiValue!)!

  /// Locate Byte relative to source string providerd
  ///
  /// - Parameter b: The asciiValue representing the character to put into relation.
  /// - Returns: relative position within source string.
  private func _byteToOrder(_ b: UInt8) -> UInt8 {
    let numberFloorByte = Character("0").asciiValue!
    let numberCeilByte = Character("9").asciiValue!
    let capitalFloorByte = Character("A").asciiValue!
    let capitalCeilByte = Character("Z").asciiValue!
    let lowerFloorByte = Character("a").asciiValue!
    let lowerCeilByte = Character("z").asciiValue!
    
    if(b >= numberFloorByte && b <= numberCeilByte) {
      return b - numberFloorByte
    } else if (b >= lowerFloorByte && b <= lowerCeilByte) {
      return b - lowerFloorByte + 10 + 26
    } else if (b >= capitalFloorByte && b <= capitalCeilByte) {
      return b - capitalFloorByte + 10
    } else if (b < capitalFloorByte) {
      return 0
    } else {
      return 10 + 26 + 26 - 1
  }}
  
  /// Locate Byte relative to source string providerd
  ///
  /// - Parameter b: The asciiValue representing the character to put into relation.
  /// - Returns: relative position within source string, or nil if value is invalid.
  private func byteToOrder(_ b: UInt8) -> UInt8? {
    let n = _byteToOrder(b)
    if n < 0 || n > 62 { return nil }
    return n
  }
 
  
  /// Generate a string to fit between two given string, by comparing chars of the two parameters.
  ///
  /// - Parameter prev: The string located earlier within the collection in relation to the string to be generated
  /// - Parameter next: The string located later within the collection in relation to the string to be generated.
  /// - Returns: a new string, to fit inbetween those two given.
  public func order(_ prev: String?, _ next: String?) -> String? {
    var _prev = [UInt8]((prev ?? "").map { byteToOrder($0.asciiValue!)! })
    var _next = [UInt8]((next ?? "").map { byteToOrder($0.asciiValue!)! })
    
    if(_prev.isEmpty) { _prev.append(minChar) }
    if(_next.isEmpty) { _next.append(maxChar) }
    
    var rank: [UInt8] = []
    for i in 0...max(_prev.count, _next.count) {
      
      let prevChar = i < _prev.endIndex
      ? _prev[_prev.index(_prev.startIndex, offsetBy: i)]
      : minChar
      
      let nextChar = i < _next.endIndex
      ? _next[_next.index(_next.startIndex, offsetBy: i)]
      : maxChar
      
      if(prevChar == nextChar) { rank.append(prevChar); continue }
      
      let avg = Int((prevChar + nextChar) / 2)
      if( avg == prevChar || avg == nextChar ) { rank.append(prevChar); continue }
      
      rank.append(UInt8(avg))
      break
    }
    
    let r = String(rank.map { orderToByte[orderToByte.index(orderToByte.startIndex, offsetBy: Int($0))] })
    let n = String(_next.map { orderToByte[orderToByte.index(orderToByte.startIndex, offsetBy: Int($0))] })
    
    if r < n || (next ?? "").isEmpty {
      return r
    }
    return nil
  }
}
