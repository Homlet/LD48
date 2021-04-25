package me.samhubbard.ld48.state;

class PlayState {
    
    public var ballsLeft: Float;

    public var nextWave: Int;

    public function new(ballsLeft: Float) {
        this.ballsLeft = ballsLeft;
        nextWave = 1;
    }
}
