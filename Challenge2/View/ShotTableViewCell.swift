
//

import UIKit
import AVFoundation
class ShotTableViewCell: UITableViewCell, ASAutoPlayVideoLayerContainer {
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var shotImageView: UIImageView!
    var playerController: ASVideoPlayerController?
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    var videoURL: String? {
        didSet {
            if let videoURL = videoURL {
                ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
            }
            videoLayer.isHidden = videoURL == nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shotImageView.layer.cornerRadius = 5
        shotImageView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        shotImageView.clipsToBounds = true
        shotImageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        shotImageView.layer.borderWidth = 0.5
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = AVLayerVideoGravity.resize
        shotImageView.layer.addSublayer(videoLayer)
        selectionStyle = .none
    }
    
    func configureCell(imageUrl: String?,
                       description: String,
                       videoUrl: String?, profileUrl: String?, comment: String?) {
        self.descriptionLabel.text = description
        self.shotImageView.imageURL = imageUrl
        self.videoURL = videoUrl
        self.profileImageView.load(url: URL(string: profileUrl!)!)
        self.descriptionLbl.text = "\(description) shared \(comment!)"
//        self.likesLbl.text = "\(likes!) likes"
    }

    override func prepareForReuse() {
        shotImageView.imageURL = nil
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let horizontalMargin: CGFloat = 20
        let width: CGFloat = bounds.size.width - horizontalMargin * 2
        let height: CGFloat = (width * 0.9).rounded(.up)
        videoLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func visibleVideoHeight() -> CGFloat {
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(shotImageView.frame, from: shotImageView)
        guard let videoFrame = videoFrameInParentSuperView,
            let superViewFrame = superview?.frame else {
             return 0
        }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
    @IBAction func likeButtonAction(_ sender: Any) {
    }
    @IBAction func commentButtonAction(_ sender: Any) {
    }
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    @IBAction func muteUnmuteButtonAction(_ sender: Any) {
        print("YES")
        ASVideoPlayerController.sharedVideoPlayer.mute = true
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
