//
//  UITableView-extension.swift
//  Plus500
//
//  Created by Bary Levy on 25/05/2021.
//

import UIKit

extension UITableView {
    open func dequeueCell<T: UITableViewCell>(cellType identifier: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: identifier.self), for: indexPath) as! T
    }
}
