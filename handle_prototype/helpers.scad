module error_msg(msg) {
    // Print the message in msg in nice, bright red
    echo(str("<font color='red'><b>",msg,"</b></font>"));
}

error_msg("Error!");
