package me.samhubbard.ld48.entity;

import nape.phys.BodyType;
import nape.shape.Polygon;
import me.samhubbard.game.Entity;
import h2d.Graphics;

class BlockEntity extends Entity {

    public function new(x: Float, y: Float) {
        super(x, y, (scene) -> {
            var graphics = new Graphics(scene);
            graphics.beginFill(Colour.BLOCK);
            graphics.drawRect(-Settings.BLOCK_WIDTH / 2, -10, Settings.BLOCK_WIDTH, 20);
            graphics.endFill();
            return graphics;
        }, BodyType.KINEMATIC, EntityType.BLOCK);

        // Create the collider
        var shape = new Polygon(Polygon.rect(-Settings.BLOCK_WIDTH / 2, -10, Settings.BLOCK_WIDTH, 20));
        shape.material = Settings.MATERIAL_BOUNCY;
        body.shapes.add(shape);
    }

    public function destroy() {
        // TODO: special effects, power ups
        remove();
    }

	private function onAdd() {}

    private function update(dt: Float) {}

	private function onRemove() {}
}
