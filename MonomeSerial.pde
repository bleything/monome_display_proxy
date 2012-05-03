void monome_set_prefix( String new_prefix ) {
	prefix = new_prefix;
	println( "Prefix is now " + prefix + " ... " );

	from_monome.plug( this, "led_state", prefix + "/led" );
	from_monome.plug( this, "led_col", prefix + "/led_col" );
	from_monome.plug( this, "button_press", prefix + "/press" );

	OscMessage msg = new OscMessage( "/sys/prefix" );
	msg.add( new_prefix );
	from_monome.send( msg, to_application );
}

void monome_set_prefix( int offset, String new_prefix ) {
	monome_set_prefix( new_prefix );
}