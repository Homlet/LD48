package me.samhubbard.ld48.entitygroup;

import me.samhubbard.ld48.entity.Destroyable;
import polygonal.ds.ArrayList;
import me.samhubbard.ld48.entity.BlockEntity;

class HoleyBlockWave extends BlockWave {

    public function new() {
        super();
    }

    public function generateBlocks(xOffset: Float, y: Float): ArrayList<Destroyable> {
        var output = new ArrayList<Destroyable>();
        var x = 20 + xOffset + Settings.BLOCK_WIDTH;
        while (x <= Settings.PLAY_WIDTH - 20 - Settings.BLOCK_WIDTH) {
            var roll = Math.random();
            if (roll > Settings.HOLE_CHANCE) {
                output.add(new BlockEntity(x, y));
            }
            x += Settings.BLOCK_WIDTH + 20;
        }
        if (output.size == 0) {
            // Probably won't recurse too much. Hacky fix to prevent row
            // with no blocks at all.
            trace("HEQ");
            return generateBlocks(xOffset, y);
        }
        return output;
    }
}
