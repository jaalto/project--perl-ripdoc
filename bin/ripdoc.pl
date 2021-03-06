#!/usr/bin/perl
#
#   Copyright
#
#       Copyright (C) 1997-2019 Jari Aalto
#
#   License
#
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   Documentation
#
#       To read manual, start this program with option: --help

# ****************************************************************************
#
#   Globals
#
# ****************************************************************************

#   The following variable is updated by developer's Emacs whenever
#   this file is saved

our $VERSION = '2019.0505.1514';

# ****************************************************************************
#
#   Standard modules
#
# ****************************************************************************

use strict;
use English;
use Getopt::Long;
use autouse 'Pod::Text'     => qw( pod2text );
use autouse 'Pod::Html'     => qw( pod2html );

# ****************************************************************************
#
#   DESCRIPTION
#
#       Set global variables for the program
#
#   INPUT PARAMETERS
#
#       none
#
#   RETURN VALUES
#
#       none
#
# ****************************************************************************

sub Initialize ()
{
    use vars qw
    (
        $PROGNAME
        $LIB
        $CONTACT
        $URL
    );

    $PROGNAME   = "ripdoc.pl";
    $LIB        = $PROGNAME;
    $CONTACT    = "";
    $URL        = "";

    $OUTPUT_AUTOFLUSH = 1;
}

# ***************************************************************** &help ****
#
#   DESCRIPTION
#
#       Print help and exit.
#
#   INPUT PARAMETERS
#
#       $msg    [optional] Reason why function was called.-
#
#   RETURN VALUES
#
#       none
#
# ****************************************************************************

=pod

=head1 NAME

ripdoc - Rip documentation from the beginning of file

=head1 SYNOPSIS

    ripdoc.pl FILE ...

=head1 DESCRIPTION

=head2 General

Some programming languages, like Perl and Java, are execptions because
they include a way to embed documentating inside a program. In other
programming languages, like in Shell programs, Procmail scripts, Emacs
Lisp extensions, there is nothing out of the box that would help to
document the program to the outside world. The choices are:

=over 4

=item *

A separate document(s) for the program is maintained: nin Unix man
page *.1 format, using text files .txt, Latex *.tex, write texinfo
Info pages *.info, SGML, etc.

=item *

Programs display a brief/complete manual when invoked with B<-h> or
B<--help> option.

=item *

Documentation is put to the beginning of the file and distributed with
the file. User must open the file to a C<$EDITOR> to see how the
program is used.

=back

This utility is aimed for the last bullet. The documentation is
maintained at the beginning of the distributed files. Program extracts
the documentation which follows TF (Technical text format) guidelines.
The idea is that you can generate e.g. HTML documentation similarly
that what Perl utility pod2html does. The conversion goes like this:

    ripdoc.pl program.sh | t2html > manual.html

=head2 How to write documentation

In order to use this program, the documentation is written in rigid
format starting from the beginning of file. An example:

    #!/bin/sh
    #
    # file.extension -- proper first line description
    #
    #   Preface starts at column 4
    #
    #       txt txt txt at column 8
    #       txt txt txt at column 8
    #
    #           Further example code at column 12
    #           More code examples at column 12
    #
    #   Next heading at column 4
    #
    #       txt txt txt at column 8
    #       txt txt xtx at column 8
    #       txt txt xtx at column 8

That's is. It is important to keep the heading at half-tab column and
rest of the standard paragraphs at tab column. Each position is
advanced by 4 spaces forward leading to column 12 which is reserved
for verbatim text, like code examples.

=head2 Specification for the documenation format

The very first line determines the comment string in the file. The
documentation starts when a header I<Preface> or I<File> I<Id> is
found

    #   Preface         # or "File id"

Documentation ends when either of these headers are found:

    #   Change Log:     # or "History"

The I<Preface> should explain how the package sprang into
existence and the rest of the documentation follows after that.

Most important is the first line or near first, if the file is a
shell script, must be exactly like the following. You _must_ not
use double dashes in any other heading.This gives the name
of the file and description string. Use what(1) marker at the
beginning of sentence.

    # file.extension -- proper first line description

=head2 Notes on documentation format

Very first line determines what is the comment string that is ripped
away from the beginning of lines. Remember to start writing of
headings at column four and write text at standard tab column 8. You
must not use multiple of comment markers like used below; it will
handicap this utility.

    #!/bin/sh
    #
    ####################################################### WRONG
    #
    # file.extension -- proper first line description
    #
    ####################################################### WRONG

=head1 OPTIONS

=over 4

=item B<--doc>

Use default seach start: 'Documentation|Commentary'

=item B<-b, --begin-regexp REGEXP>

Search any beginning regexp matching RE instead of default 'File id|Preface'

=item B<-d, --doc>

Set search regexp to 'Documentation:|Commentary:'.

=item B<-D, --debug>

Turn on debug.

=item B<-e, --end-regexp REGEXP>

Search any Ending regexp matching RE instead of default 'Change Log|History'

=item B<-h, --help>

Display help page.

=item B<-i, --ignore-regexp>

Ignore lines matching RE. The default value ignores shell I<!/slash/bang>
lines.

=item B<-v, --verbose>

Turn on verbose messages.

=item B<-V, --version>

Display program version and contact info.

=back

=head1 EXAMPLES

Extract documentation Program t2html(1) can be used to convert
documentation into HTML.

    ripdoc file.sh > manual.txt
    t2html manual.txt > manual.html

=head1 SEE ALSO

html2ps(1)
ps2ascii(1)
t2html(1)
weblint(1)

=head1 EXIT STATUS

Not defined.

=head1 DEPENDENCIES

Uses standard Perl modules.

=head1 BUGS AND LIMITATIONS

You can run this program to rip out documentation from any file that
follows the 4 character indentation rule, which is the basis of TF
(technical text format). The only requirement is that the comment
markers are single lined. C and Java-styled I<comment-start>
I<comment-end> combination cannot be handled, because the comment
marker is determined from the start of file.

    /* This comment documentation cannot be handled
     *
     */

=head1 AVAILABILITY

https://github.com/jaalto/project--perl-ripdoc
See also https://github.com/jaalto/project--perl-text2html

=head1 AUTHOR

Program was written by Jari Aalto.

This program is free software; you can redistribute and/or modify
program under the terms of GNU General Public license either version 2
of the License, or (at your option) any later version.

=cut

sub Help ( ; $ $ )
{
    my $id   = "$LIB.Help";
    my $msg  = shift;  # optional arg, why are we here...
    my $type = shift;  # optional arg, type

    if ( $type eq -html )
    {
        pod2html $PROGRAM_NAME;
    }
    elsif ( $type eq -man )
    {
        eval { require Pod::Man; 1 }
            or die "$id: Cannot generate Man: $EVAL_ERROR";

        my %options;
        $options{center} = 'Perl Dynamic DNS Update Client';

        my $parser = Pod::Man->new(%options);
        $parser->parse_from_file ($PROGRAM_NAME);
    }
    else
    {
        system "pod2text $PROGRAM_NAME";
    }

    if ( defined $msg )
    {
        print $msg;
        exit 1;
    }

    exit 0;
}

# ************************************************************** &args *******
#
#   DESCRIPTION
#
#       Read and interpret command line arguments ARGV. Sets global variables
#
#   INPUT PARAMETERS
#
#       none
#
#   RETURN VALUES
#
#       none
#
# ****************************************************************************

sub HandleCommandLineArgs ()
{
    my $id = "$LIB.HandleCommandLineArgs";

    my ( $help, $helpHTML, $helpMan, $version, $doc );

    use vars qw
    (
        $BEGIN_REGEXP
        $END_REGEXP
        $IGNORE_REGEXP
        $QUIET
        $debug
        $verb
    );

    # ............................................... default values ...

    #   RCS Revision "Log" ends the description.

    $BEGIN_REGEXP   = 'File id|Preface';
    $END_REGEXP     = 'Change\s+Log|History|[$]Log: ';

    #   Ignore shebang lines

    $IGNORE_REGEXP   = '^.![/].*[/]';
    $debug           = 0;

    # .................................................... read args ...

    GetOptions      # Getopt::Long
    (
          "help"                => \$help
        , "help-html"           => \$helpHTML
        , "help-man"            => \$helpMan
        , "b|begin-regexp=s"    => \$BEGIN_REGEXP
        , "doc"                 => \$doc
        , "D|debug"             => \$debug
        , "e|end-regexp=s"      => \$END_REGEXP
        , "i|ignore-regexp=s"   => \$IGNORE_REGEXP
        , "verbose"             => \$verb
        , "V|version"           => \$version

    );

    $version        and die "$VERSION $PROGNAME $CONTACT $URL\n";
    $help           and Help();
    $helpHTML       and Help undef, -html;
    $helpMan        and Help undef, -man;
    $verb = 1       if  $debug;

    if ( $doc )
    {
        $BEGIN_REGEXP = 'Documentation:|Commentary:';
    }
}

# ****************************************************************************
#
#   DESCRIPTION
#
#       Main entry point
#
#   INPUT PARAMETERS
#
#       none
#
#   RETURN VALUES
#
#       none
#
# ****************************************************************************

sub Main ()
{
    Initialize();
    HandleCommandLineArgs();

    my $BODY                = 0;
    my $BODY_MATCH_REGEXP   = "";
    my $COMMENT             = "";
    my $PADDING             = "";

    my ( $ch1, $rest, $name );
    local $ARG;

    while ( <> )
    {
        next if /$IGNORE_REGEXP/o;

        if ( $COMMENT eq "" )
        {
            #   Find out what commenting syntax is for this file

            $COMMENT = $1 if /([^\s\n]+)/;

            if ( $COMMENT =~ /^;/ )         # Emacs lisp
            {
                $COMMENT = ";";
            }

            #   We must preserve indentation when removing comments.

            $PADDING = " " x length $COMMENT;

            $BODY_MATCH_REGEXP =
                    "([-a-zA-Z0-9.])([-a-zA-Z0-9.]+" .
                    "\\s+--+\\s+.*)"
                    ;

            $debug  and print "INIT: COMMENT [$COMMENT] ARG [$ARG]";
        }

        if ( $debug  and  /$BODY_MATCH_REGEXP/o )
        {
            printf "!!$BODY %d [$1] [$2] $ARG", length $PREMATCH;
        }

        # ..................................... first line documentation ...
        #   Get first line name

        if ( not $BODY
             and /$BODY_MATCH_REGEXP/o
             #  the match to the left size must be short
             and length $PREMATCH < 20
           )
        {
            $debug  and  print "BODY: $ARG";

            # convert first character to uppercase.

            ($ch1, $rest) = ($1, $2);

            if ( $ch1 !~ /[a-zA-Z]/ )
            {
                $verb and warn "$LIB: First line does not"
                             , " begin with letter. [$ARG] \n";

                $name = "$ch1$rest";
            }
            else
            {
                $name = uc($ch1) . $rest;
            }

            $debug  and  print "BODY: $name\n";
        }

        # ....................................................... bounds ...

        if  ( ! $BODY  and  /^$COMMENT+ \s+ (?:$BEGIN_REGEXP)/oix )
        {
            $BODY = 1;
            $debug  and  printf "BEG:[$&] [$ARG]";
        }

        if  ( /^$COMMENT+ \s+ (?:$END_REGEXP)/oix )
        {
            $BODY = 0;
            $debug  and  printf "END:[$&] [$ARG]";
            next;
        }

        if ( $BODY )
        {
            $BODY == 1  and  print "$name\n\n";
            $BODY++;

            #  Emacs Lisp Details
            #   Ignore: ;; ............ &thisTag ...
            #   Ignore: folding.el tags ';; }}}' and ';; {{{'
	    #   Convert multiple comments into spaces

            next if /^;; \.\.|\}\}\}|\{\{\{/;
	    s/^(;;)+/ " " x length($1) /e;

            # ................................................. &general ...

            s/^($COMMENT)/$PADDING/o;

            #   Make sure that:
            #
            #      Header 1 is here
            #   ^^^ 3 spaces is converted to 4 spaces.

            if ( /^ {3,4}(\w)(.*)/  )
            {
                $ARG = "    " . uc($1) . $2 . "\n";
            }

	    s/[ \t]+$//;	    # delete EOL whitespaces

            print "$ARG";
        }
    }
}

Main();

# End of file
