package me.samhubbard.ld48.entitygroup;

import me.samhubbard.ld48.entity.Destroyable;
import polygonal.ds.ArrayList;
import me.samhubbard.ld48.entity.BlockEntity;

class HoleyBlockWave extends BlockWave {

    public function new() {
        super();
    }

	public function generateBlocks(y: Float): ArrayList<Destroyable> {
		var output = new ArrayList<Destroyable>();
        var x = 20 + Settings.BLOCK_WIDTH;
        while (x <= Settings.PLAY_WIDTH - 20 - Settings.BLOCK_WIDTH) {
            var roll = Math.random();
            if (roll > Settings.HOLE_CHANCE) {
                output.add(new BlockEntity(x, y));
            }
            x += Settings.BLOCK_WIDTH + 20;
        }
        return output;
	}
}
