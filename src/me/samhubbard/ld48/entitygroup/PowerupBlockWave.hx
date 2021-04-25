package me.samhubbard.ld48.entitygroup;

import me.samhubbard.ld48.entity.Destroyable;
import me.samhubbard.ld48.entity.MagnetBlockEntity;
import polygonal.ds.ArrayList;
import me.samhubbard.ld48.entity.BlockEntity;

class PowerupBlockWave extends BlockWave {

    private final powerup: Class<Destroyable>;

    public function new(powerup: Class<Destroyable>) {
        super();

        this.powerup = powerup;
    }

	public function generateBlocks(y: Float): ArrayList<Destroyable> {
        var powerupPosition = Math.random() * Settings.PLAY_WIDTH;
        var powerupPlaced = false;
		var output = new ArrayList<Destroyable>();
        var x = 20 + Settings.BLOCK_WIDTH;
        while (x <= Settings.PLAY_WIDTH - 20 - Settings.BLOCK_WIDTH) {
            if (x > powerupPosition && !powerupPlaced) {
                output.add(Type.createInstance(powerup, [x, y]));
                powerupPlaced = true;
            } else {
                output.add(new BlockEntity(x, y));
            }
            x += Settings.BLOCK_WIDTH + 20;
        }
        return output;
	}
}
