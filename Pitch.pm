package MIDI::Pitch;

use 5.00503;
use strict;

require Exporter;
use vars qw($VERSION @ISA @EXPORT_OK
            %name2pitch_lut @pitch2name_table);

@ISA = qw(Exporter);
@EXPORT_OK = qw(name2pitch pitch2name);
$VERSION = '0.1';

=head1 NAME

MIDI::Pitch - Converts MIDI pitches and note names into each other

=head1 SYNOPSIS

  use MIDI::Pitch;

  # see below
  
=head1 DESCRIPTION

This module converts MIDI pitches between 0 and 127 (called 'note numbers'
in the MIDI standard) and note names into each other. The octave
numbers are based on the table found in the MIDI standard (see
L<http://www.harmony-central.com/MIDI/Doc/table2.html>):

    The MIDI specification only defines note number 60 as "Middle C", and
    all other notes are relative. The absolute octave number designations
    shown here are based on Middle C = C4, which is an arbitrary
    assignment.

The note names are C<C>, C<C#>/C<Db>, C<D>, ..., followed by an octave
number from -1 to 9. Thus, the valid notes ranges between C<C-1> and
C<G9>.

=head1 FUNCTIONS

=head2 name2pitch($name)

Converts a note name into a pitch. 

=cut

%name2pitch_lut = (
    'b#' => 0,
    c    => 0,
    'c#' => 1,
    'db' => 1,
    d    => 2,
    'd#' => 3,
    'eb' => 3,
    e    => 4,
    'fb' => 4,
    'e#' => 5,
    f    => 5,
    'f#' => 6,
    'gb' => 6,
    g    => 7,
    'g#' => 8,
    'ab' => 8,
    a    => 9,
    'a#' => 10,
    'bb' => 10,
    b    => 11,
    'cb' => 11);

sub name2pitch {
    my $n = shift;
    
    return undef unless defined $n && lc($n) =~ /^([a-g][b#]?)(-?\d\d?)$/;
    
    my $p = $name2pitch_lut{$1} + ($2 + 1) * 12;
    return undef unless $p >= 0 && $p <= 127;
    return $p;
}

=head2 pitch2name($pitch)

Converts a pitch between 0 and 127 into a note name. pitch2name returns
the lowercase version with a sharp, if necessary (e.g. it will return
'g#', not 'Ab').

=cut

@pitch2name_table = ('c', 'c#', 'd', 'd#', 'e', 'f',
                     'f#', 'g', 'g#', 'a', 'a#', 'b');

sub pitch2name {
    my $p = shift;
    
    return undef unless defined $p && $p =~ /^\d+$/ && $p >= 0 && $p <= 127;
    
    return $pitch2name_table[$p % 12] . (int($p / 12) - 1);
}

=head1 HISTORY

=over 8

=item 0.1

Original version; created by h2xs 1.22 with options

  -A -C -X -n MIDI::Pitch -v 0.1 -b 5.5.3

=back

=head1 SEE ALSO

L<MIDI>. L<MIDI::Tools>.

L<http://www.harmony-central.com/MIDI/Doc/table2.html>

=head1 AUTHOR

Christian Renz, E<lt>crenz@web42.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Christian Renz

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
