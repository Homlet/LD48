package me.samhubbard.ld48.entitygroup;

import polygonal.ds.ArrayList;
import me.samhubbard.ld48.entity.BlockEntity;

class StandardBlockWave extends BlockWave {

	public function generateBlocks(y: Float): ArrayList<BlockEntity> {
		var output = new ArrayList<BlockEntity>();
        var x = 60;
        while (x <= Settings.WIDTH - 60) {
            output.add(new BlockEntity(x, y));
            x += 40;
        }
        return output;
	}
}
