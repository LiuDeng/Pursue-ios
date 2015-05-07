//
//  ChatRoomViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/19.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class ChatRoomViewController: JSQMessagesViewController, UICollectionViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var chatRoomViewModel = ChatRoomViewModel(chatRoom: ChatRoom(from: Current.User, to: PursueUser(userName: "222222")))
    
    var timer: NSTimer = NSTimer()
    
//    var groupId: String = ""
    
    
    var bubbleFactory = JSQMessagesBubbleImageFactory()
    var outgoingBubbleImage: JSQMessagesBubbleImage!
    var incomingBubbleImage: JSQMessagesBubbleImage!
    
    var senderImageUrl: String!
    var batchMessages = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = Current.User.userName
        self.senderDisplayName = Current.User.userName
        
        outgoingBubbleImage = bubbleFactory.outgoingMessagesBubbleImageWithColor(Theme.ForegroundColor)
        incomingBubbleImage = bubbleFactory.incomingMessagesBubbleImageWithColor(Theme.ContentBackgroundColor)
        collectionView.backgroundColor = Theme.BackgroundColor
        
        chatRoomViewModel.isLoading = false
//        loadMessages()
        
        //        Messages.clearMessageCounter(groupId);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.collectionViewLayout.springinessEnabled = true
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "loadMessages", userInfo: nil, repeats: true)
    }
    
    func loadMessages(){
        chatRoomViewModel.loadMessagesWithBlock(loadedMessage)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    
    // Mark: - Backend methods
    
    func loadedMessage(objects: [AnyObject]!, error: NSError!){
        if error == nil {
            self.automaticallyScrollsToMostRecentMessage = false
            for object in (objects as! [AVObject]!) {
                self.addMessage(object)
            }
            if objects.count > 0 {
                self.finishReceivingMessage()
                self.scrollToBottomAnimated(false)
            }
            self.automaticallyScrollsToMostRecentMessage = true
        } else {
            println("Network error")
        }
    }
    
    func addMessage(object: AVObject) {
        var message = ChatMessage(text: (object.objectForKey("content") as! String), senderId: (object.objectForKey("senderId") as! String),senderDisplayName: "Luce")
        
//        var user = object[PF_CHAT_USER] as PFUser
//        var name = user[PF_USER_FULLNAME] as String
//        
//        var videoFile = object[PF_CHAT_VIDEO] as? PFFile
//        var pictureFile = object[PF_CHAT_PICTURE] as? PFFile
        
        var videoFile: AVFile? = nil
        var pictureFile: AVFile? = nil
        
//        if videoFile == nil && pictureFile == nil {
//            message = PursueMessage(senderId: Current.User.userName, senderDisplayName: name, date: object.createdAt, text: "消息内容")
//        }
//        
//        if videoFile != nil {
//            var mediaItem = JSQVideoMediaItem(fileURL: NSURL(string: videoFile!.url), isReadyToPlay: true)
//            message = PursueMessage(senderId: Current.User.userName, senderDisplayName: name, date: object.createdAt, media: mediaItem)
//        }
//        
//        if pictureFile != nil {
//            var mediaItem = JSQPhotoMediaItem(image: nil)
//            mediaItem.appliesMediaViewMaskAsOutgoing = (Current.User.userName == self.senderId)
//            message = PursueMessage(senderId: Current.User.userName, senderDisplayName: name, date: object.createdAt, media: mediaItem)
//            
//            pictureFile!.getDataInBackgroundWithBlock({ (imageData: NSData!, error: NSError!) -> Void in
//                if error == nil {
//                    mediaItem.image = UIImage(data: imageData)
//                    self.collectionView.reloadData()
//                }
//            })
//        }
        
        chatRoomViewModel.users.append(Current.User)
        chatRoomViewModel.messages.append(message)
    }
    
    func sendMessage(receiveId: String, text: String, video: NSURL?, picture: UIImage?) {
//        var videoFile: PFFile!
//        var pictureFile: PFFile!
//        
//        if let video = video {
//            text = "[Video message]"
//            videoFile = PFFile(name: "video.mp4", data: NSFileManager.defaultManager().contentsAtPath(video.path!))
//            
//            videoFile.saveInBackgroundWithBlock({ (succeeed: Bool, error: NSError!) -> Void in
//                if error != nil {
//                    ProgressHUD.showError("Network error")
//                }
//            })
//        }
//        
//        if let picture = picture {
//            text = "[Picture message]"
//            pictureFile = PFFile(name: "picture.jpg", data: UIImageJPEGRepresentation(picture, 0.6))
//            pictureFile.saveInBackgroundWithBlock({ (suceeded: Bool, error: NSError!) -> Void in
//                if error != nil {
//                    ProgressHUD.showError("Picture save error")
//                }
//            })
//        }
//        
//        var object = PFObject(className: PF_CHAT_CLASS_NAME)
//        object[PF_CHAT_USER] = PFUser.currentUser()
//        object[PF_CHAT_GROUPID] = self.groupId
//        object[PF_CHAT_TEXT] = text
//        if let videoFile = videoFile {
//            object[PF_CHAT_VIDEO] = videoFile
//        }
//        if let pictureFile = pictureFile {
//            object[PF_CHAT_PICTURE] = pictureFile
//        }
//        object.saveInBackgroundWithBlock { (succeeded: Bool, error: NSError!) -> Void in
//            if error == nil {
//                JSQSystemSoundPlayer.jsq_playMessageSentSound()
//                self.loadMessages()
//            } else {
//                ProgressHUD.showError("Network error")
//            }
//        }
//        
//        PushNotication.sendPushNotification(groupId, text: text)
//        Messages.updateMessageCounter(groupId, lastMessage: text)
        
        var message = ChatMessage(text: text, senderId: Current.User.userName, senderDisplayName: "Luce")
        chatRoomViewModel.users.append(Current.User)
        self.chatRoomViewModel.messages.append(message)
        message.save({ (success, error) -> () in
            self.loadMessages()
            self.finishSendingMessage()
        })
    }
    
    // MARK: - JSQMessagesViewController method overrides
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        self.sendMessage("222222", text: text, video: nil, picture: nil)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        var action = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Take photo", "Choose existing photo", "Choose existing video")
        action.showInView(self.view)
    }
    
    // MARK: - JSQMessages CollectionView DataSource
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return chatRoomViewModel.messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        var message = chatRoomViewModel.messages[indexPath.item]
        if message.senderId() == self.senderId {
            return outgoingBubbleImage
        }
        return incomingBubbleImage
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        var user = chatRoomViewModel.users[indexPath.item]
        return user.avatar
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        if indexPath.item % 3 == 0 {
            var message = chatRoomViewModel.messages[indexPath.item]
            return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date())
        }
        return nil;
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        var message = chatRoomViewModel.messages[indexPath.item]
        if message.senderId() == self.senderId {
            return nil
        }
        
        if indexPath.item - 1 > 0 {
            var previousMessage = chatRoomViewModel.messages[indexPath.item - 1]
            if previousMessage.senderId() == message.senderId() {
                return nil
            }
        }
        return NSAttributedString(string: message.senderDisplayName())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        return nil
    }
    
    // MARK: - UICollectionView DataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatRoomViewModel.messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        var message = chatRoomViewModel.messages[indexPath.item]
        if message.senderId() == self.senderId {
            cell.textView?.textColor = UIColor.whiteColor()
        } else {
            cell.textView?.textColor = UIColor.blackColor()
        }
        return cell
    }
    
    // MARK: - UICollectionView flow layout
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if indexPath.item % 3 == 0 {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        return 0
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        var message = chatRoomViewModel.messages[indexPath.item]
        if message.senderId() == self.senderId {
            return 0
        }
        
        if indexPath.item - 1 > 0 {
            var previousMessage = chatRoomViewModel.messages[indexPath.item - 1]
            if previousMessage.senderId() == message.senderId() {
                return 0
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 0
    }
    
    // MARK: - Responding to CollectionView tap events
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, header headerView: JSQMessagesLoadEarlierHeaderView!, didTapLoadEarlierMessagesButton sender: UIButton!) {
        println("didTapLoadEarlierMessagesButton")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapAvatarImageView avatarImageView: UIImageView!, atIndexPath indexPath: NSIndexPath!) {
        println("didTapAvatarImageview")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAtIndexPath indexPath: NSIndexPath!) {
        var message = chatRoomViewModel.messages[indexPath.item] as JSQMessageData
        if message.isMediaMessage() {
            if let mediaItem = message.media as? JSQVideoMediaItem {
//                var moviePlayer = MPMoviePlayerViewController(contentURL: mediaItem.fileURL)
//                self.presentMoviePlayerViewControllerAnimated(moviePlayer)
//                moviePlayer.moviePlayer.play()
            }
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapCellAtIndexPath indexPath: NSIndexPath!, touchLocation: CGPoint) {
        println("didTapCellAtIndexPath")
    }
    
    // MARK: - UIActionSheetDelegate
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex != actionSheet.cancelButtonIndex {
//            if buttonIndex == 0 {
//                Camera.shouldStartCamera(self, canEdit: true)
//            } else if buttonIndex == 1 {
//                Camera.shouldStartPhotoLibrary(self, canEdit: true)
//            } else if buttonIndex == 2 {
//                Camera.shouldStartVideoLibrary(self, canEdit: true)
//            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var video = info[UIImagePickerControllerMediaURL] as? NSURL
        var picture = info[UIImagePickerControllerEditedImage] as? UIImage
        
        self.sendMessage("222222", text: "", video: video, picture: picture)
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}