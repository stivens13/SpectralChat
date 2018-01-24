//
//  ChatListCell.swift
//  SpeactralChatProto
//
//  Created by John Mai on 1/23/18.
//  Copyright © 2018 Nikita Voloshenko. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
