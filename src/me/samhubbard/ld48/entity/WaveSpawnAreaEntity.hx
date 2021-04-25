package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.entitygroup.StandardBlockWave;
import me.samhubbard.game.Entity;
import nape.callbacks.CbEvent;
import nape.phys.BodyType;
import nape.shape.Polygon;

/**
 * Sensor entity which defines the region offscreen where block waves are spawned. When
 * there are no blocks in this region a new wave can be spawned.
 */
class WaveSpawnAreaEntity extends Entity {

    private var blockCount: Int;

    private var justSpawned: Bool;

    private var spawnY: Float;

    public function new(x: Float, y: Float, width: Float, height: Float) {
        super(x, y, null, BodyType.STATIC, EntityType.SPAWNER);

        blockCount = 0;
        justSpawned = false;
        spawnY = y + height;

        // Create the collider
        var shape = new Polygon(Polygon.rect(0, 0, width, height));
        shape.sensorEnabled = true;
        body.shapes.add(shape);
    }

	private function onAdd() {
        registerSensorCallback(CbEvent.BEGIN, EntityType.BLOCK, (block) -> {
            justSpawned = false;
            blockCount++;
            trace(blockCount);
        });
        registerSensorCallback(CbEvent.END, EntityType.BLOCK, (block) -> {
            blockCount--;
            trace(blockCount);
        });
    }

    private function spawn() {
        var wave = new StandardBlockWave();
        wave.spawn(spawnY);
        act.add(wave);
        justSpawned = true;
    }

    private function update(dt: Float) {
        if (blockCount == 0 && !justSpawned) {
            trace("SPAWN");
            spawn();
        }
    }

	private function onRemove() {}
}
