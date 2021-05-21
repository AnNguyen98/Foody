//
//  NotificationsViewModel.swift
//  Foody
//
//  Created by MBA0283F on 5/20/21.
//

import Combine

final class RNotificationsViewModel: ViewModel, ObservableObject {
    @Published var notifications: [Notifications] = []
    
    func getNotifications() {
        isLoading = true
        CommonServices.getNotifications()
            .sink { (completion) in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (notifications) in
                self.notifications = notifications.sorted(by: { $0.time < $1.time})
            }
            .store(in: &subscriptions)
    }
    
    func markReadNotification(_ notification: Notifications) {
        CommonServices.markReadNotification(id: notification._id)
            .sink { (completion) in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { (noti) in
                if let index = self.notifications.firstIndex(of: noti) {
                    self.notifications[index] = noti
                }
            }
            .store(in: &subscriptions)
    }
}
