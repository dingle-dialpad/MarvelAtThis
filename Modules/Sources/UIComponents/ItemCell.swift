//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit

final class CosmicEventCell: UICollectionViewCell {
    let thumbnail = UIImageView(frame: .zero)
    let title = UILabel(frame: .zero)
    let subtitle = UILabel(frame: .zero)
    let countLabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(thumbnail)
        addSubview(title)
        addSubview(subtitle)
        addSubview(countLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


