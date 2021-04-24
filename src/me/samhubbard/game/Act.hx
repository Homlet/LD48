package me.samhubbard.game;

import nape.space.Space;
import h2d.Scene;
import polygonal.ds.HashSet;
import polygonal.ds.ListSet;

abstract class Act {

    private static inline final ENTITY_SET_SLOT_COUNT = 1024;

    public final scene: Scene;

    public final space: Space;

    public var disposed(default, null): Bool;

    private final entitiesToAdd: ListSet<Entity>;

    private final entities: HashSet<Entity>;

    private final entitiesToRemove: ListSet<Entity>;

    public function new(width: Int, height: Int) {
        scene = new Scene();
        scene.scaleMode = ScaleMode.Fixed(width, height, 1, ScaleModeAlign.Center, ScaleModeAlign.Center);
        space = new Space();
        disposed = false;
        entitiesToAdd = new ListSet<Entity>();
        entities = new HashSet<Entity>(ENTITY_SET_SLOT_COUNT);
        entitiesToRemove = new ListSet<Entity>();
    }

    public abstract function init(): Void;

    public function update(dt: Float) {
        if (disposed) {
            return;
        }

        for (entity in entitiesToAdd) {
            entity.notifyAdded(this, scene);
            entities.set(entity);
        }
        entitiesToAdd.clear();

        for (entity in entities) {
            entity.notifyUpdate(dt);
        }

        for (entity in entitiesToRemove) {
            entity.notifyRemoved();
            entities.remove(entity);
        }
        entitiesToRemove.clear();
    }

    public function add(entity: Entity): Bool {
        if (disposed) {
            return false;
        }

        entitiesToAdd.set(entity);
        return true;
    }

    public function remove(entity: Entity): Bool {
        if (disposed) {
            return false;
        }

        if (!entities.has(entity)) {
            return false;
        }

        entitiesToRemove.set(entity);
        return true;
    }

    public function dispose() {
        // TODO: check we are not currently adding or removing entities
        for (entity in entities) {
            entity.notifyRemoved();
        }
        entities.clear();
        entitiesToAdd.clear();
        entitiesToRemove.clear();

        scene.dispose();
        disposed = true;
    }
}
