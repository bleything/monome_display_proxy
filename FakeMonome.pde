void led_state( int column, int row, int state ) {
	if( state == 1 ) {
		pads[row][column].light();
	} 
	else {
		pads[row][column].snuff();
	}
}

void led_col( int column, int states, int throwaway ) {
	led_col( column, states );
}

void led_col( int column, int states ) {
	for( int row = 0; row < 8; row++ ) {
		if( (states & ( 1 << row )) == 0 ) {
			// bit is clear
			pads[row][column].snuff();
		} 
		else {
			// bit is set!
			pads[row][column].light();
		} 
	}
}

void button_press( int column, int row, int state ) {
	if( state == 1 ) {
		pads[row][column].press();
	} 
	else {
		pads[row][column].release();
	}
	
	OscMessage msg = new OscMessage( prefix + "/press" );
	msg.add( column );
	msg.add( row );
	msg.add( state );
	from_monome.send( msg, to_application );
}