
#use strict;

print "<a href=\"..\">Skyserver.org</a>\n";
do_dir('.',"|","../");
exit;

sub do_dir {
    my $dir = shift;
    my $depth = shift;
    my $path = shift;

    opendir(D, $dir);
    
    my @f = readdir(D);
    closedir(D);
    foreach my $file (@f) {
        my $filename = $dir . '\\' . $file;
	my $ref = "$path/$file";
	$_ = $file;
	next if (/CVS/);
	next if (/img/);
	next if (/images/);
	next if (/mosaicparts/);
	next if (/edu/);
	next if (/gutter.aspx/);
	next if (/shell.aspx/);
	next if (/soon.aspx/);
	next if (/pic.aspx/);
	next if (/pici.aspx/);
	next if (/SkyHeader.aspx/);
	next if (/SkyFooter.aspx/);
	next if (/META-INF/);
	next if (/scripts/);

        if (!($file eq '.' || $file eq '..')) {

	   if (/aspx/ && !/default.aspx/) {
             print "$depth---<a href=\"$ref\">$file</a>\n";
	   }	
           if (-d $filename) {
             print "$depth---<a href=\"$ref\">$file</a>\n";
             do_dir($filename,"$depth   |","$path/$dir/$file"); 
           } 
	}
         
    }
}


