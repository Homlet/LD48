package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.state.PlayState;
import h2d.Graphics;
import h2d.Object;
import hxd.res.DefaultFont;
import h2d.Text;
import nape.phys.BodyType;
import me.samhubbard.game.Entity;

class GameOverEntity extends Entity {

    private var instr: Text;

    private var t: Float;

    public function new(x: Float, y: Float, state: PlayState) {
        super(x, y, (scene) -> {
            var root = new Object(scene);
            var font = DefaultFont.get();
            var gameover = new Text(font, root);
            gameover.textColor = Colour.TEXT_GAME_OVER;
            gameover.text = "GAME\nOVER";
            gameover.scale(5);
            gameover.x = -gameover.textWidth * 5 / 2;
            gameover.y = -gameover.textHeight * 5;
            var score = new Text(font, root);
            score.textColor = Colour.TEXT_FINAL_SCORE;
            score.text = 'FINAL SCORE: ${state.score}';
            score.scale(2.5);
            score.x = -score.textWidth * 2.5 / 2;
            score.y = 40;
            instr = new Text(font, root);
            instr.textColor = Colour.TEXT_FINAL_SCORE;
            instr.text = 'press space to continue . . .';
            instr.x = -instr.textWidth / 2;
            positionInstrY();
            return root;
        }, BodyType.STATIC);

        t = 0;
    }

    private function positionInstrY() {
        instr.y = 200 + 2 * Std.int(Math.sin(t * 2) * 3);
    }

	private function onAdd() {}

    private function update(dt: Float) {
        t += dt;

        positionInstrY();
    }

	private function onRemove() {}
}
