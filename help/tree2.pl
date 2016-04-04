#!/usr/local/bin/perl

use strict;

print "<a href=\"..\">Skyserver.org</a>\n";
do_dir('.',"|","..");
exit;

sub do_dir {
    my $dir = shift;
    my $depth = shift;
    my $path = shift;

    opendir(D, $dir);
    
    my @f = readdir(D);
    closedir(D);
    foreach my $file (@f) {
        my $filename = $dir . '/' . $file;
	my $ref = "$path/$file";
	$_ = $file;
	next if (/CVS/);
	next if (/src/);
	next if (/img/);
	next if (/images/);
	next if (/mosaicparts/);
	next if (/redfinder/);
	next if (/thumb/);
	next if (/safe/);
	next if (/save/);
	next if (/physlet/);
	next if (/get/);
	next if (/browser/);
	next if (/proj_cd/);
	next if (/old/);
	next if (/thrash/);

        if (!($file eq '.' || $file eq '..')) {

	   #if (/asp/) {
           #  print "$depth---<a href=\"$ref\">$file</a>\n";
	   #}	
           if (-d $filename) {
             print "$depth---<a href=\"$ref\">$file</a>\n";
	     next if (/advanced/);
	     next if (/java/);
	     next if (/basic/);
	     next if (/challenges/);
	     next if (/games/);
	     next if (/kids/);
	     next if (/teachers/);
	     next if (/download/);
	     next if (/howto/);
             do_dir($filename,"$depth   |","$path/$dir/$file"); 
           } 
	}
         
    }
}


