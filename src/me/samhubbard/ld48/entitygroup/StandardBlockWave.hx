package me.samhubbard.ld48.entitygroup;

import me.samhubbard.ld48.entity.Destroyable;
import polygonal.ds.ArrayList;
import me.samhubbard.ld48.entity.BlockEntity;

class StandardBlockWave extends BlockWave {

    public function generateBlocks(xOffset: Float, y: Float): ArrayList<Destroyable> {
        var output = new ArrayList<Destroyable>();
        var x = 20 + xOffset + Settings.BLOCK_WIDTH;
        while (x <= Settings.PLAY_WIDTH - 20 - Settings.BLOCK_WIDTH) {
            output.add(new BlockEntity(x, y));
            x += Settings.BLOCK_WIDTH + 20;
        }
        return output;
    }
}
