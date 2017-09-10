//
//  ChatController.swift
//  FireChat
//
//  Created by Tomer Buzaglo on 04/09/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//
import UIKit
import MessageKit

class ChatController: MessagesViewController {
    
    var messageList: [MessageType] = [
        Message(text: "Woot? I ❤️ Swift", sender: mockSender, messageId: "1"),
        Message(text: "I Meant it. Objective c is Here to Stay", sender: mockFriend, messageId: "2"),
        Message(text: "No, Were going for swift.", sender: mockSender, messageId: "3"),
        Message(text: "I Just Unwrapped this optional language 🎩", sender: mockSender, messageId: "4"),
        Message(text: "Now, That's Impersive", sender: mockFriend, messageId: "5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.messageLabelDelegate = self
        messageInputBar.delegate = self
        
        setupInputBar()
    }
    
    func setupInputBar() {
        // Makes buttons with various 'hooks'
        
        let items = [
            
            makeButton(named: "ic_camera").onTextViewDidChange { button, textView in
                button.isEnabled = textView.text.isEmpty
            },
            makeButton(named: "ic_library").onTextViewDidChange { button, textView in
                button.isEnabled = textView.text.isEmpty
            },
            makeButton(named: "ic_at"),
            makeButton(named: "ic_hashtag"),
            .flexibleSpace,
            messageInputBar.sendButton
                .configure {
                    $0.layer.cornerRadius = 8
                    $0.layer.borderWidth = 1.5
                    $0.layer.borderColor = $0.titleColor(for: .disabled)?.cgColor
                    $0.setTitleColor(UIColor(colorLiteralRed: 15/255, green: 135/255, blue: 255/255, alpha: 1.0), for: .normal)
                    $0.setTitleColor(.white, for: .highlighted)
                    $0.setSize(CGSize(width: 52, height: 30), animated: false)
                }.onDisabled {
                    $0.layer.borderColor = $0.titleColor(for: .disabled)?.cgColor
                }.onEnabled {
                    $0.layer.borderColor = UIColor(colorLiteralRed: 15/255, green: 135/255, blue: 255/255, alpha: 1.0).cgColor
                }.onSelected {
                    $0.backgroundColor = UIColor(colorLiteralRed: 15/255, green: 135/255, blue: 255/255, alpha: 1.0)
                }.onDeselected {
                    $0.backgroundColor = .white
            }
        ]
        
        //We can change the container insets if we want
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        
        // Adjust the padding
        messageInputBar.padding.top = 8
        messageInputBar.padding.bottom = 8
        messageInputBar.textViewPadding.bottom = 8
        
        // Since we moved the send button to the bottom stack lets set the right stack width to 0
        messageInputBar.setRightStackViewWidthContant(to: 0, animated: false)
        
        // Finally set the items
        messageInputBar.setStackViewItems(items, forStack: .bottom, animated: false)
    }
    
    func makeButton(named: String) -> InputBarButtonItem {
        return InputBarButtonItem()
            .configure {
                $0.title = named
                $0.image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
                $0.setSize(CGSize(width: 40, height: 40), animated: false)
                $0.layer.cornerRadius = 8
                $0.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
            }.onKeyboardEditingBegins {
                $0.setSize(CGSize(width: 30, height: 30), animated: true)
            }.onKeyboardEditingEnds {
                $0.setSize(CGSize(width: 40, height: 40), animated: true)
            }.onSelected {
                $0.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
                $0.tintColor = .white
            }.onDeselected {
                $0.backgroundColor = .white
                $0.tintColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
            }.onTouchUpInside {btn  in
                print("Item Tapped")
                
                guard let title = btn.title else{return}
                
                switch title{
                case "ic_camera":
                    print("Camera")
                case "ic_at":
                    print("@")
                case "ic_library":
                    print("Photo Library")
                case "ic_hashtag":
                    print("#")
                default:
                    break
                }
        }
    }
}

let mockSender = Sender(id: "1", displayName: "Steve Jobs")
let mockFriend = Sender(id: "2", displayName: "Tim Cook")

// MARK: - MessagesDataSource
extension ChatController: MessagesDataSource {
    
    func currentSender() -> Sender {
        return mockSender
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
}

// MARK: - MessagesDisplayDataSource
extension ChatController: MessagesDisplayDataSource {
    
    func avatar(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Avatar {
        
        return message.sender == mockSender ? Avatar(image: #imageLiteral(resourceName: "Steve-Jobs"), initals: "SJ") : Avatar(image: #imageLiteral(resourceName: "Tim-Cook"), initals: "TC")
    }
    
    func avatarPosition(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> AvatarPosition {
        return .messageTop
    }
    
    func messageHeaderView(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageHeaderView? {
        return messagesCollectionView.dequeueMessageHeaderView(for: indexPath)
    }
    
    func messageFooterView(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageFooterView? {
        return messagesCollectionView.dequeueMessageFooterView(for: indexPath)
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption2)])
    }
    
}

// MARK: - MessagesLayoutDelegate
extension ChatController: MessagesLayoutDelegate {
    
    func headerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: messagesCollectionView.bounds.width, height: 4)
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: messagesCollectionView.bounds.width, height: 4)
    }
    
}

// MARK: - MessageCellDelegate
extension ChatController: MessageCellDelegate {
    
    func didTapAvatar(in cell: MessageCollectionViewCell) {
        print("Avatar tapped")
    }
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        print("Message tapped")
    }
    
    func didTapTopLabel(in cell: MessageCollectionViewCell) {
        print("Top label tapped")
    }
    
    func didTapBottomLabel(in cell: MessageCollectionViewCell) {
        print("Bottom label tapped")
    }
    
}

// MARK: - MessageLabelDelegate
extension ChatController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String : String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
        print("URL Selected: \(url)")
    }
    
}

// MARK: - MessageInputBarDelegate
extension ChatController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        messageList.append(Message(text: text, sender: currentSender(), messageId: UUID().uuidString))
        
        inputBar.inputTextView.text = String()
        messagesCollectionView.reloadData()
    }
    
}
