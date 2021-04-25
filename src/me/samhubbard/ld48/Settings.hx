package me.samhubbard.ld48;

import nape.phys.Material;

class Settings {

    public static final WIDTH: Int = 480;

    public static final HEIGHT: Int = 640;

    public static final BALL_MIN_SPEED: Float = 70;

    public static final BALL_MAX_SPEED: Float = 600;

    public static final BALL_RESET_RATE: Float = 0.5;

    public static final PADDLE_SPEED: Float = 400;

    public static final PADDLE_MAX_MOMENTUM: Float = 500;

    public static final PADDLE_MOMENTUM_RATE: Float = 2500;

    public static final MATERIAL_BOUNCY: Material = new Material(1.0, 0.0, 0.0, 1.0, 0.0);
}
