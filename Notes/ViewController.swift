import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gameFieldView: GameFieldView!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var gameControl: GameControlViewClass!
    func actionButtonTapped() {
        if gameControl.isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    private var gameTimer: Timer?
    private var timer: Timer?
    private let displayDuration: TimeInterval = 2
    private var score = 0

    private func startGame() {
        score = 0
        repositionImageWithTimer()
        
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(gameTimerTick),
            userInfo: nil,
            repeats: true
        )
        
        gameControl.gameTimeLeft = gameControl.gameDuration
        gameControl.isGameActive = true
        updateUI()
    }
    
    @objc private func gameTimerTick() {
        gameControl.gameTimeLeft -= 1
        
        if gameControl.gameTimeLeft == 0 {
            stopGame()
        } else {
            updateUI()
        }
    }
    
    func objectTapped() {
        guard gameControl.isGameActive else { return }
        repositionImageWithTimer()
        score += 1
    }
    
    private func updateUI() {
        gameFieldView.isShapeHidden = !gameControl.isGameActive
    }

    @objc private func moveImage() {
        gameFieldView.randomizeShape()
    }
    
    private func repositionImageWithTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: displayDuration,
            target: self,
            selector: #selector(moveImage),
            userInfo: nil,
            repeats: true
        )
        timer?.fire()
    }

    private func stopGame() {
        gameControl.isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
        
        scoreLabel.text = "Последний счет: \(score)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        gameFieldView.shapeHitHandler = { [weak self] in
            self?.objectTapped()
        }

        gameFieldView.layer.borderWidth = 1
        gameFieldView.layer.borderColor = UIColor.gray.cgColor
        gameFieldView.layer.cornerRadius = 5
        
        gameControl.startStopHandler = { [weak self] in
            self?.actionButtonTapped()
        }
        gameControl.gameDuration = 20
        
//        Logger.logger.info("App was runned")
//
//        let notebook = Notebook()
//        do {
//            try notebook.loadFromFile()
//        } catch {
//            Logger.logger.error(error.localizedDescription)
//        }
    }
}


