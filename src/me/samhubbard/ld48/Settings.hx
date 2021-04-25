package me.samhubbard.ld48;

import nape.phys.Material;

class Settings {

    public static final WIDTH: Int = 480;

    public static final HEIGHT: Int = 640;

    public static final PLAY_WIDTH: Int = 420;

    public static final BALL_MIN_SPEED: Float = 200;

    public static final BALL_MAX_SPEED: Float = 600;

    public static final BALL_RESET_RATE: Float = 0.5;

	public static final PADDLE_WIDTH: Float = 50;

    public static final PADDLE_SPEED: Float = 800;

    public static final PADDLE_MAX_MOMENTUM: Float = 400;

    public static final PADDLE_MOMENTUM_RATE: Float = 3000;

	public static final PADDLE_MAGNET_RATE: Float = 30;

	public static final PADDLE_MAGNET_REFILL_RATE: Float = 5;

    public static final BLOCK_WIDTH: Float = 50;

    public static final BLOCK_SCROLL_SPEED: Float = 14;

    public static final BLOCK_MAGNET_AMOUNT: Float = 33;

    public static final HUD_MAGNET_HEIGHT: Float = 100;

    public static final MATERIAL_BOUNCY: Material = new Material(1.0, 0.0, 0.0, 1.0, 0.0);
}
