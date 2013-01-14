use inc::Module::Install;

our $script = 'script/merge_gg_silva';

# Package information
name     'merge_gg_silva';
all_from $script;
license  'gpl3'; # Module::Install 1.04 does not parse the GPL version number
resources
   homepage   'https://github.com/fangly/merge_gg_silva';
   bugtracker 'https://github.com/fangly/merge_gg_silva';
   repository 'https://github.com/fangly/merge_gg_silva';

# Dependencies for everyone
requires        'Bio::Root::Version'         =>  0; # Bioperl
requires        'Getopt::Euclid'             => '0.3.9';

# Dependencies for authors only
author_requires 'Module::Install';
author_requires 'Module::Install::AuthorRequires';
author_requires 'Module::Install::AutoLicense';
author_requires 'Module::Install::PodFromEuclid';
author_requires 'Module::Install::ReadmeFromPod' => 0.14;
author_requires 'Module::Install::AutoManifest';

# Install dependencies
auto_install;

# Scripts to install
install_script $script;

# Generate MANIFEST file
auto_manifest();

# Generate Makefile and META.yml files
WriteAll;

# Generate the LICENSE file
auto_license();

# Generate the README and manpage files from the POD docs
auto_doc();



#--------- UTILS --------------------------------------------------------------#


sub auto_doc {
   print "*** Building doc...\n";
   pod_from $script;
   my $clean   = 1;
   my $man_dir = 'man';
   if (not -d $man_dir) {
      mkdir $man_dir or die "Could not write folder $man_dir:\n$!\n";
   }
   readme_from $script, $clean, 'txt', 'README';
   readme_from $script, $clean, 'htm', 'README.htm';
   readme_from $script, $clean, 'man', "$man_dir/merge_gg_silva.1";
   return 1;
}
