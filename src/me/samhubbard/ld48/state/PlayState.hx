package me.samhubbard.ld48.state;

class PlayState {

    public var score: Int;

    public var magnet: Float;

    public var magnetCooldown: Bool;
    
    public var ballsLeft: Float;

    public var nextWave: Int;

    public function new(ballsLeft: Float) {
        score = 0;
        magnet = 100;
        magnetCooldown = false;
        this.ballsLeft = ballsLeft;
        nextWave = 1;
    }
}
