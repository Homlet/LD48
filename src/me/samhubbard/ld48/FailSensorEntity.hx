package me.samhubbard.ld48;

import me.samhubbard.game.Entity;
import nape.callbacks.CbEvent;
import nape.phys.BodyType;
import nape.shape.Polygon;

class FailSensorEntity extends Entity {

    public function new(x: Float, y: Float, width: Float, height: Float) {
        super(x, y, null, BodyType.STATIC, EntityType.BOUNDARY);

        // Create the collider
        var shape = new Polygon(Polygon.rect(0, 0, width, height));
        shape.material = Settings.MATERIAL_BOUNCY;
        shape.sensorEnabled = true;
        body.shapes.add(shape);
    }

	private function onAdd() {
        registerSensorCallback(CbEvent.END, EntityType.BALL, (ball) -> {
            if (act is PlayAct) {
                cast(act, PlayAct).resetBall(cast(ball, BallEntity));
            }
        });
    }

    private function update(dt: Float) {}

	private function onRemove() {}
}
