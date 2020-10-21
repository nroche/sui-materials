/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Combine
import SwiftUI
import Foundation

final class UserManager: ObservableObject {
  @Published
  var profile: Profile = Profile()
  
  @Published
  var settings: Settings = Settings()
  
  var isRegistered: Bool {
    return profile.name.isEmpty == false
  }
  
  init() {
  }
  
  init(name: String) {
    self.profile.name = name
  }
  
  func persistProfile() {
    if settings.rememberUser {
      UserDefaults.standard.set(try? PropertyListEncoder().encode(profile), forKey: "user-profile")
    }
  }
  
  func persistSettings() {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey: "user-settings")
  }
  
  func load() {
    if let data = UserDefaults.standard.value(forKey: "user-profile") as? Data {
      if let profile = try? PropertyListDecoder().decode(Profile.self, from: data) {
        self.profile = profile
      }
    }
    
    if let data = UserDefaults.standard.value(forKey: "user-settings") as? Data {
      if let settings = try? PropertyListDecoder().decode(Settings.self, from: data) {
        self.settings = settings
      }
    }
  }
  
  func clear() {
    UserDefaults.standard.removeObject(forKey: "user-profile")
  }
  
  func isUserNameValid(_ name: String) -> Bool {
    return name.count >= 3
  }
}