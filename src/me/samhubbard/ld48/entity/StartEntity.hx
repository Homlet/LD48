package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.state.PlayState;
import h2d.Graphics;
import h2d.Object;
import hxd.res.DefaultFont;
import h2d.Text;
import nape.phys.BodyType;
import me.samhubbard.game.Entity;

class StartEntity extends Entity {

    private var instr: Text;

    private var t: Float;

    public function new(x: Float, y: Float, state: PlayState) {
        super(x, y, (scene) -> {
            var root = new Object(scene);
            var font = DefaultFont.get();
            var breakin = new Text(font, root);
            breakin.textColor = Colour.TEXT_GAME_OVER;
            breakin.text = "BREAKIN!";
            breakin.scale(5);
            breakin.x = -breakin.textWidth * 5 / 2;
            breakin.y = -breakin.textHeight * 5;
            instr = new Text(font, root);
            instr.textColor = Colour.TEXT_FINAL_SCORE;
            instr.text = 'press space to begin . . .';
            instr.x = -instr.textWidth / 2;
            positionInstrY();
            return root;
        }, BodyType.STATIC);

        t = 0;
    }

    private function positionInstrY() {
        instr.y = 150 + 2 * Std.int(Math.sin(t * 2) * 3);
    }

    private function onAdd() {}

    private function update(dt: Float) {
        t += dt;

        positionInstrY();
    }

    private function onRemove() {}
}
