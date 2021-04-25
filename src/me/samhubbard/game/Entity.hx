package me.samhubbard.game;

import h2d.Object;
import h2d.Drawable;
import h2d.Scene;
import nape.callbacks.PreFlag;
import nape.callbacks.PreCallback;
import nape.callbacks.PreListener;
import nape.geom.Vec2;
import nape.constraint.WeldJoint;
import nape.callbacks.Listener;
import polygonal.ds.ArrayList;
import nape.callbacks.CbType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionType;
import nape.callbacks.InteractionListener;
import nape.callbacks.CbEvent;
import nape.phys.Body;
import nape.phys.BodyType;
import polygonal.ds.Hashable;
import polygonal.ds.HashKey;

abstract class Entity implements Actor {

    public final key: Int;

    // TODO: better solution
    private final drawableFactory: Scene -> Object;

    private final cbType: CbType;

    private final listeners: ArrayList<Listener>;

    public final body: Body;

    private var weldee: Entity;

    private var welded(get, never): Bool;

    private var drawable: Object;

    private var act: Act;

    private var group: EntityGroup;

    private function new(x: Float, y: Float, drawableFactory: Scene -> Object,
                         bodyType: BodyType=null, entityType: CbType=null) {
        key = HashKey.next();
        this.drawableFactory = drawableFactory;

        // Create the physics body
        body = new Body(bodyType);
        body.position.setxy(x, y);
        body.userData.entity = this;
        cbType = new CbType();
        body.cbTypes.add(cbType);
        // TODO: allow multiple entity types to be added by modifying the EntityType class to have a fluent API
        if (entityType != null) {
            body.cbTypes.add(entityType);
        }
        listeners = new ArrayList<Listener>();
    }

    private function registerSensorCallback(event: CbEvent, type: Dynamic, callback: Entity -> Void) {
        var wrapper = (info: InteractionCallback) -> {
            callback(info.int2.castBody.userData.entity);
        };
        var listener = new InteractionListener(event, InteractionType.SENSOR, cbType, type, wrapper);

        listeners.add(listener);
        act.space.listeners.add(listener);
    }

    private function registerCollisionCallback(event: CbEvent, type: Dynamic, callback: Entity -> Void) {
        var listener: Listener = null;
        if (event == CbEvent.PRE) {
            var wrapper = (info: PreCallback) -> {
                callback(info.int2.castBody.userData.entity);
                return PreFlag.ACCEPT;
            };
            listener = new PreListener(InteractionType.COLLISION, cbType, type, wrapper);
        } else {
            var wrapper = (info: InteractionCallback) -> {
                callback(info.int2.castBody.userData.entity);
            };
            listener = new InteractionListener(event, InteractionType.COLLISION, cbType, type, wrapper);
        }

        listeners.add(listener);
        act.space.listeners.add(listener);
    }

    private function weldKey(other: Entity) {
        return '${Math.min(this.key, other.key)}-${Math.max(this.key, other.key)}';
    }

    private function weldTo(other: Entity): Bool {
        if (welded) {
            return false;
        }

        for (constraint in body.constraints) {
            if (constraint.userData.key == weldKey(other)) {
                return false;
            }
        }

        var anchor = other.body.worldPointToLocal(body.position);
        var phase = other.body.rotation - body.rotation;
        var joint = new WeldJoint(body, other.body, Vec2.get(0, 0), anchor, phase);

        weldee = other;
        joint.userData.key = weldKey(other);
        act.space.constraints.add(joint);

        return true;
    }

    private function unweld(): Bool {
        if (!welded) {
            return false;
        }

        for (constraint in body.constraints) {
            if (constraint.userData.key == weldKey(weldee)) {
                weldee = null;
                act.space.constraints.remove(constraint);
                return true;
            }
        }

        return false;
    }

    @:allow(me.samhubbard.game.EntityGroup)
    @:allow(me.samhubbard.game.Act)
    private function notifyAdded(act: Act, scene: Scene) {
        this.act = act;

        if (drawableFactory != null) {
            drawable = drawableFactory(scene);
        }

        body.space = act.space;

        onAdd();
    }

    @:allow(me.samhubbard.game.EntityGroup)
    private function notifyAddedToGroup(group: EntityGroup) {
        this.group = group;
    }

    @:allow(me.samhubbard.game.EntityGroup)
    @:allow(me.samhubbard.game.Act)
    private function notifyUpdate(dt: Float) {
        update(dt);

        if (drawable != null) {
            drawable.setPosition(body.position.x, body.position.y);
        }
    }
    
    @:allow(me.samhubbard.game.EntityGroup)
    @:allow(me.samhubbard.game.Act)
    private function notifyRemoved() {
        body.space = null;

        for (listener in listeners) {
            act.space.listeners.remove(listener);
        }
        listeners.clear();

        if (drawable != null) {
            drawable.remove();
            drawable = null;
        }

        act = null;

        onRemove();
    }

    @:allow(me.samhubbard.game.EntityGroup)
    private function notifyRemoveFromGroup() {
        group = null;
    }

    public function remove(): Bool {
        if (group != null) {
            group.remove(this);
        } else if (act != null) {
            act.remove(this);
        } else {
            return false;
        }

        return true;
    }

    private abstract function onAdd(): Void;

    private abstract function update(dt: Float): Void;

    private abstract function onRemove(): Void;

    private function get_welded():Bool {
        return weldee != null;
    }
}
