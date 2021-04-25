package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.state.PlayState;
import h2d.Graphics;
import h2d.Object;
import hxd.res.DefaultFont;
import h2d.Text;
import nape.phys.BodyType;
import me.samhubbard.game.Entity;

class HUDEntity extends Entity {

    private var width: Float;

    private var state: PlayState;

    private var score: Text;

    private var magnet: Graphics;

    public function new(x: Float, y: Float, width: Float, state: PlayState) {
        super(x, y, (scene) -> {
            var root = new Object(scene);
            var font = DefaultFont.get();
            score = new Text(font, root);
            score.text = "123";
            magnet = new Graphics(root);
            drawMagnet(state.magnet);
            return root;
        }, BodyType.STATIC);

        this.width = width;
        this.state = state;
    }

    private function drawMagnet(level: Float) {
        magnet.clear();
        magnet.beginFill((state.magnetCooldown) ? Colour.MAGNET_COOLDOWN : Colour.MAGNET);
        magnet.drawRect(0, 30, width, Settings.HUD_MAGNET_HEIGHT * level / 100);
        magnet.endFill();
    }

	private function onAdd() {}

    private function update(dt: Float) {
        if (score != null) {
            score.text = '${state.score}';
        }

        if (magnet != null) {
            drawMagnet(state.magnet);
        }
    }

	private function onRemove() {}
}
