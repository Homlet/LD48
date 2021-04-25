package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.act.PlayAct;
import me.samhubbard.game.Entity;
import nape.callbacks.CbEvent;
import nape.phys.BodyType;
import nape.shape.Polygon;

/**
 * Sensor entity which defines the failure region immediately behind the paddle. If a
 * ball or block reaches this area, a penalty is given to the player.
 */
class FailSensorEntity extends Entity {

    public function new(x: Float, y: Float, width: Float, height: Float) {
        super(x, y, null, BodyType.STATIC, EntityType.BOUNDARY);

        // Create the collider
        var shape = new Polygon(Polygon.rect(0, 0, width, height));
        shape.sensorEnabled = true;
        body.shapes.add(shape);
    }

    private function onAdd() {
        registerSensorCallback(CbEvent.BEGIN, EntityType.BLOCK, (ball) -> {
            if (act is PlayAct) {
                cast(act, PlayAct).fail();
            }
        });
        registerSensorCallback(CbEvent.END, EntityType.BALL, (ball) -> {
            if (act is PlayAct) {
                cast(act, PlayAct).lostBall(cast(ball, BallEntity));
            }
        });
    }

    private function update(dt: Float) {}

    private function onRemove() {}
}
