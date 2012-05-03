class ButtonPad {
	private int padding = 18;
	private int dimensions = 36;

	private int origin_x, origin_y;
	private boolean lit = false;
	private boolean pressed = false;

	ButtonPad( int row, int column ) {
		origin_x = padding + (column * padding) + (column * dimensions);
		origin_y = padding + (row * padding) + (row * dimensions);
	}

	public void render() {
		if( lit ) {
			fill( 0, 255, 0 );
		} else {
			fill( 255, 255, 255 );
		}

		rect( origin_x, origin_y, dimensions, dimensions );
		
		if( pressed ) {
			fill( 0 );
			
			int offset = dimensions / 4;
			int disc_size = dimensions / 2;
			ellipse( origin_x + offset, origin_y + offset, disc_size, disc_size );
		}
	}

	public void light()   { lit     = true;  }
	public void snuff()   { lit     = false; }
	public void press()   { pressed = true;  }
	public void release() { pressed = false; }
}
