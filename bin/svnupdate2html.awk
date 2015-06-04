#!/usr/bin/awk -f
BEGIN {
	FS = "|";
	new_record = "true";
	first_record = "true";
	print "<html>";
	print "<head><title>SVN Log</title>"
	print "<table class=\"outer\">";
	print "  <style>";
	print "    table           { width: 100%; border-collapse: collapse; }";
	print "    .outer td       { border: solid 2px black; }";
	print "    .log_entry td   { border: solid 1px gray; }";
	print "    .entry_rev      { width: 10%; }";
	print "    .entry_submiter { width: 25%; }";
	print "    .entry_time     { width: 40%; }";
	print "    .entry_lines    { width: 25%; }";
	print "  </style>";
	print "</head>";
	print "<body>";
}

/^----------------*/ {
	if (first_record !~ /true/)
	{
		print "      </td></tr>";
		print "    </table>";
		print "</td></tr>";
	}
	first_record = "false";
	new_record = "true";
	next;
}

/^r\d*/ { 
	if (new_record ~ /true/)
	{
		print "<tr><td>";

		print "    <table class=\"log_entry\" width=\"15%\">";
		print "      <tr>";
		print "      <td rowspan=\"2\" class=\"entry_rev\"><a href=\"http://svn.bybaxter.com/cgi-bin/viewvc.cgi/prophet?view=rev&revision="substr($1,2)"\">" $1 "</a></td>";
		print "      <td class=\"entry_submiter\">" $2 "</td>";
		print "      <td class=\"entry_time\">" $3 "</td>";
		print "      <td class=\"entry_lines\">" $4 "</td>";
		print "      </tr>";
		print "      <tr><td colspan=\"" NF - 1 "\">";
		new_record = false;
		next;
	}
}

{
    print $0 "<br/>";
}

END {
	print "</table>";
    print "</body>\n</html>";
}
