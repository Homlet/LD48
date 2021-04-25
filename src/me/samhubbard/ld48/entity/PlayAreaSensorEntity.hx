package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.act.PlayAct;
import me.samhubbard.game.Entity;
import nape.callbacks.CbEvent;
import nape.phys.BodyType;
import nape.shape.Polygon;

/**
 * Fallback sensor which defines the play area. If a ball leaves the play area
 * due to a bug it is immediately reset with no penalties to the player.
 */
class PlayAreaSensorEntity extends Entity {

    public function new(x: Float, y: Float, width: Float, height: Float) {
        super(x, y, null, BodyType.STATIC, EntityType.BOUNDARY);

        // Create the collider
        var shape = new Polygon(Polygon.rect(0, 0, width, height));
        shape.sensorEnabled = true;
        body.shapes.add(shape);
    }

    private function onAdd() {
        registerSensorCallback(CbEvent.END, EntityType.BALL, (ball) -> {
            if (act is PlayAct) {
                cast(act, PlayAct).resetBall(cast(ball, BallEntity));
                trace("OOPS");
            }
        });
    }

    private function update(dt: Float) {}

    private function onRemove() {}
}
