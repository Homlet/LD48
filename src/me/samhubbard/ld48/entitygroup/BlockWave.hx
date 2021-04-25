package me.samhubbard.ld48.entitygroup;

import me.samhubbard.game.EntityGroup;
import polygonal.ds.ArrayList;
import me.samhubbard.ld48.entity.BlockEntity;

abstract class BlockWave extends EntityGroup {

	private abstract function generateBlocks(y: Float): ArrayList<BlockEntity>;

    public function spawn(y: Float) {
		removeAll();
		for (block in generateBlocks(y)) {
			add(block);
		}
	}

	private function onAdd() {}

	private function update(dt:Float) {
		for (block in entities) {
			block.body.velocity.y = -Settings.BLOCK_SCROLL_SPEED;
		}
	}

	private function onRemove() {}
}
