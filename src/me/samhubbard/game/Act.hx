package me.samhubbard.game;

import polygonal.ds.ArrayList;
import hxd.Key;
import nape.space.Space;
import h2d.Scene;
import polygonal.ds.HashSet;
import polygonal.ds.ListSet;

abstract class Act {

    private static inline final ACTOR_SET_SLOT_COUNT = 1024;

    public final scene: Scene;

    public final space: Space;

    public var disposed(default, null): Bool;

    private var paused(default, null): Bool;

    private final actorsToAdd: ListSet<Actor>;

    private final actors: HashSet<Actor>;

    private final actorsToRemove: ListSet<Actor>;

    private final game: Game;

    public function new(width: Int, height: Int, game: Game) {
        scene = new Scene();
        scene.scaleMode = ScaleMode.LetterBox(width, height);
        space = new Space();
        disposed = false;
        paused = false;
        actorsToAdd = new ListSet<Actor>();
        actors = new HashSet<Actor>(ACTOR_SET_SLOT_COUNT);
        actorsToRemove = new ListSet<Actor>();
        this.game = game;
    }

    public function pause() {
        paused = true;
    }

    public function unpause() {
        paused = false;
    }

    public function togglePause(): Bool {
        paused = !paused;
        return paused;
    }

    public function notifyUpdate(dt: Float) {
        if (disposed) {
            return;
        }

        if (Key.isPressed(Key.ESCAPE)) {
            togglePause();
        }

        if (paused) {
            return;
        }

        for (actor in actorsToAdd) {
            actor.notifyAdded(this, scene);
            actors.set(actor);
        }
        actorsToAdd.clear();

        update(dt);

        for (actor in actors) {
            actor.notifyUpdate(dt);
        }

        space.step(dt);

        for (actor in actorsToRemove) {
            actor.notifyRemoved();
            actors.remove(actor);
        }
        actorsToRemove.clear();
    }

    public abstract function init(userData: Dynamic): Void;

    public abstract function update(dt: Float): Void;

    public function addAll(actors: ArrayList<Actor>): Bool {
        var success = true;

        for (actor in actors) {
            if (!add(actor)) {
                success = false;
            }
        }

        return success;
    }

    public function add(actor: Actor): Bool {
        if (disposed) {
            return false;
        }

        actorsToAdd.set(actor);
        return true;
    }

    public function remove(actor: Actor): Bool {
        if (disposed) {
            return false;
        }

        if (!actors.has(actor)) {
            return false;
        }

        actorsToRemove.set(actor);
        return true;
    }

    public function removeAll(): Bool {
        if (disposed) {
            return false;
        }

        for (actor in actors) {
            actorsToRemove.set(actor);
        }

        return true;
    }

    public function dispose() {
        // TODO: check we are not currently adding or removing actors
        for (actor in actors) {
            actor.notifyRemoved();
        }
        actors.clear();
        actorsToAdd.clear();
        actorsToRemove.clear();

        scene.dispose();
        disposed = true;
    }
}
