package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.act.PlayAct;
import nape.shape.Polygon;
import h2d.Graphics;

class MagnetBlockEntity extends Destroyable {

    public function new(x: Float, y: Float) {
        super(x, y, (scene) -> {
            var graphics = new Graphics(scene);
            graphics.beginFill(Colour.MAGNET);
            graphics.drawRect(-Settings.BLOCK_WIDTH / 2, -10, Settings.BLOCK_WIDTH, 20);
            graphics.endFill();
            return graphics;
        });

        // Create the collider
        var shape = new Polygon(Polygon.rect(-Settings.BLOCK_WIDTH / 2, -10, Settings.BLOCK_WIDTH, 20));
        shape.material = Settings.MATERIAL_BOUNCY;
        body.shapes.add(shape);
    }

    public function onDestroy() {
        var playAct = cast(act, PlayAct);
        playAct.addScore(Score.MAGNET_BLOCK);
        playAct.refillMagnet(Settings.BLOCK_MAGNET_AMOUNT);
        remove();
    }

    private function onAdd() {}

    private function update(dt: Float) {}

    private function onRemove() {}
}
