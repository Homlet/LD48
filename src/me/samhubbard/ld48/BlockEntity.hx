package me.samhubbard.ld48;

import nape.phys.BodyType;
import nape.shape.Polygon;
import me.samhubbard.game.Entity;
import h2d.Graphics;

class BlockEntity extends Entity {

    public function new(x: Float, y: Float) {
        super(x, y, (scene) -> {
            var graphics = new Graphics(scene);
            graphics.beginFill(0x00ff00);
            graphics.drawRect(-20, -10, 40, 20);
            graphics.endFill();
            return graphics;
        }, BodyType.KINEMATIC, EntityType.BLOCK);

        // Create the collider
        var shape = new Polygon(Polygon.rect(-20, -10, 40, 20));
        shape.material = Settings.MATERIAL_BOUNCY;
        body.shapes.add(shape);
    }

    public function destroy() {
        act.remove(this);
    }

	private function onAdd() {}

    private function update(dt: Float) {}

	private function onRemove() {}
}
