package me.samhubbard.ld48.state;

class PlayState {

    public var score: Int;

    public var magnet: Float;

    public var magnetCooldown: Bool;
    
    public var ballsLeft: Float;

    public function new(ballsLeft: Float) {
        score = 0;
        magnet = Settings.PADDLE_MAGNET_START_AMOUNT;
        magnetCooldown = false;
        this.ballsLeft = ballsLeft;
    }
}
