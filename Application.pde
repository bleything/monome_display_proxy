void application_set_prefix( String new_prefix ) {
	prefix = new_prefix;
	println( "Prefix is now " + prefix + " ... " );

	from_application.plug( this, "led_state", prefix + "/led" );
	from_application.plug( this, "led_col", prefix + "/led_col" );

	OscMessage msg = new OscMessage( "/sys/prefix" );
	msg.add( new_prefix );
	from_application.send( msg, to_monome );
}

void application_set_prefix( int offset, String new_prefix ) {
	application_set_prefix( new_prefix );
}