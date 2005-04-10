use 5.00503;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'MIDI::Pitch',
    VERSION_FROM      => 'lib/MIDI/Pitch.pm',
    PREREQ_PM         => { Test::More => 0},
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/MIDI/Pitch.pm', # retrieve abstract from module
       AUTHOR         => 'Christian <crenz@web42.com>') : ()),
);
