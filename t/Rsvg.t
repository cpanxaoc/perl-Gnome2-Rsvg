#!/usr/bin/perl -w
use strict;
use Test::More tests => 175;
use Gnome2::Rsvg;

Gnome2::Rsvg -> set_default_dpi(96);

my $size_callback = sub {
  my ($width, $height) = @_;

  is($width, 170);
  is($height, 170);

  return ($width * 2,
          $height * 2);
};

my $svg = "t/window.svg";

###############################################################################

my $handle = Gnome2::Rsvg::Handle -> new();
isa_ok($handle, "Gnome2::Rsvg::Handle");

$handle -> set_dpi(96);
$handle -> set_size_callback($size_callback);

SKIP: {
  skip("couldn't open test image", 164)
    unless (open(SVG, $svg));

  while (<SVG>) {
    ok($handle -> write($_));
  }

  close(SVG);

  ok($handle -> close());

  my $pixbuf = $handle -> get_pixbuf();
  isa_ok($pixbuf, "Gtk2::Gdk::Pixbuf");

  is($pixbuf -> get_width(), 340);
  is($pixbuf -> get_height(), 340);
}

###############################################################################

foreach (Gnome2::Rsvg -> pixbuf_from_file($svg),
         Gnome2::Rsvg -> pixbuf_from_file_at_zoom($svg, 1.5, 1.5),
         Gnome2::Rsvg -> pixbuf_from_file_at_size($svg, 23, 42),
         Gnome2::Rsvg -> pixbuf_from_file_at_max_size($svg, 23, 42),
         Gnome2::Rsvg -> pixbuf_from_file_at_zoom_with_max($svg, 1.5, 1.5, 23, 42)) {
  isa_ok($_, "Gtk2::Gdk::Pixbuf");
}

###############################################################################

$handle = Gnome2::Rsvg::Handle -> new();
isa_ok($handle -> pixbuf_from_file_ex($svg), "Gtk2::Gdk::Pixbuf");

$handle = Gnome2::Rsvg::Handle -> new();
isa_ok($handle -> pixbuf_from_file_at_zoom_ex($svg, 1.5, 1.5), "Gtk2::Gdk::Pixbuf");

$handle = Gnome2::Rsvg::Handle -> new();
isa_ok($handle -> pixbuf_from_file_at_size_ex($svg, 23, 42), "Gtk2::Gdk::Pixbuf");

$handle = Gnome2::Rsvg::Handle -> new();
isa_ok($handle -> pixbuf_from_file_at_max_size_ex($svg, 23, 42), "Gtk2::Gdk::Pixbuf");

$handle = Gnome2::Rsvg::Handle -> new();
isa_ok($handle -> pixbuf_from_file_at_zoom_with_max_ex($svg, 1.5, 1.5, 23, 42), "Gtk2::Gdk::Pixbuf");
