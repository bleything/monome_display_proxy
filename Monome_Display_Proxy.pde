import oscP5.*;
import netP5.*;

OscP5 from_monome, from_application;
NetAddress to_monome, to_application;
ButtonPad[][] pads = new ButtonPad[8][8];

String prefix;

void setup() {
	size( 450, 450 );

	// listen to messages from apps on port 8080
	from_application = new OscP5( this, 8080 );

	// listen to monomeserial on port 7999
	from_monome = new OscP5( this, 7999 );

	// proxy messages back to monomeserial on 8081
	to_monome = new NetAddress( "127.0.0.1", 8081 );

	// proxy messages to applications on 8000
	to_application = new NetAddress( "127.0.0.1", 8000 );

	for( int row = 0; row < 8; row++ ) {
		for( int column = 0; column < 8; column++ ) {
			pads[row][column] = new ButtonPad( row, column );
		}
	}

	application_set_prefix( "/box" );
	monome_set_prefix( "/box" );

	from_monome.plug( this, "monome_set_prefix", "/sys/prefix" );
	from_application.plug( this, "application_set_prefix", "/sys/prefix" );
	
	smooth();
	
	// specify the upper-left corner of the ellipse's bounding box.  This makes it easier
	// to display the disc on a pressed button.
	ellipseMode( CORNER );
}

void draw() {
	for( int row = 0; row < 8; row++ ) {
		for( int column = 0; column < 8; column++ ) {
			pads[row][column].render();
		}
	}
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
	/* with theOscMessage.isPlugged() you check if the osc message has already been
		* forwarded to a plugged method. if theOscMessage.isPlugged()==true, it has already 
		* been forwared to another method in your sketch. theOscMessage.isPlugged() can 
		* be used for double posting but is not required.
		*/
	if(theOscMessage.isPlugged()==false) {
		/* print the address pattern and the typetag of the received OscMessage */
		println("### received an osc message.");
		println("### addrpattern\t"+theOscMessage.addrPattern());
		println("### typetag\t"+theOscMessage.typetag());
	}
}
