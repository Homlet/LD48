package me.samhubbard.ld48.entity;

import me.samhubbard.ld48.entitygroup.BlockWave;
import me.samhubbard.ld48.entitygroup.PowerupBlockWave;
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
        });
        registerSensorCallback(CbEvent.END, EntityType.BLOCK, (block) -> {
            blockCount--;
        });
    }

    private function spawn() {
        var wave: BlockWave = null;
        var roll = Math.random();
        if (roll > 0.4) {
            wave = new StandardBlockWave();
        } else if (roll > 0.2) {
            wave = new PowerupBlockWave(MagnetBlockEntity);
        } else if (roll > 0.1) {
            wave = new PowerupBlockWave(FreeBallBlockEntity);
        } else {
            wave = new PowerupBlockWave(ExtraBallBlockEntity);
        }
        wave.spawn(spawnY);
        act.add(wave);
        justSpawned = true;
    }

    private function update(dt: Float) {
        if (blockCount == 0 && !justSpawned) {
            spawn();
        }
    }

	private function onRemove() {}
}
