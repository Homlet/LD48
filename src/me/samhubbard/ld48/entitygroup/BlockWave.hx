package me.samhubbard.ld48.entitygroup;

import me.samhubbard.ld48.entity.Destroyable;
import me.samhubbard.game.EntityGroup;
import polygonal.ds.ArrayList;

abstract class BlockWave extends EntityGroup {

    private abstract function generateBlocks(xOffset: Float, y: Float): ArrayList<Destroyable>;

    public function spawn(xOffset: Float, y: Float) {
        removeAll();
        for (block in generateBlocks(xOffset, y)) {
            add(block);
        }
    }

    private function onAdd() {}

    private function update(dt:Float) {
        for (block in entities) {
            block.body.velocity.y = -Settings.BLOCK_SCROLL_SPEED;
        }

        if (entities.size == 0) {
            act.remove(this);
        }
    }

    private function onRemove() {
        trace("COOL");
    }
}
