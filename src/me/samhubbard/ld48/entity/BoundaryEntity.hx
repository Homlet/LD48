package me.samhubbard.ld48.entity;

import nape.phys.BodyType;
import me.samhubbard.game.Entity;
import nape.shape.Polygon;
import h2d.Graphics;

class BoundaryEntity extends Entity {

    public function new(x: Float, y: Float, width: Float, height: Float) {
        super(x, y, (scene) -> {
            var graphics = new Graphics(scene);
            graphics.beginFill(Colour.BOUNDARY);
            graphics.drawRect(0, 0, width, height);
            graphics.endFill();
            return graphics;
        }, BodyType.STATIC, EntityType.BOUNDARY);

        // Create the collider
        var shape = new Polygon(Polygon.rect(0, 0, width, height));
        shape.material = Settings.MATERIAL_BOUNCY;
        body.shapes.add(shape);
    }

	private function onAdd() {}

    private function update(dt: Float) {}

	private function onRemove() {}
}
