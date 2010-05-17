/*
 * Copyright (C) 2003-2005, 2010  Torsten Schoenfeld
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "rsvg2perl.h"
#include <gperl_marshal.h>

/* ------------------------------------------------------------------------- */

GPerlCallback *
rsvg2perl_size_func_create (SV *func, SV *data)
{
	return gperl_callback_new (func, data, 0, NULL, 0);
}

void
rsvg2perl_size_func (gint *width,
                     gint *height,
                     GPerlCallback *callback)
{
	int count;
	dGPERL_CALLBACK_MARSHAL_SP;
	GPERL_CALLBACK_MARSHAL_INIT (callback);

	ENTER;
	SAVETMPS;

	PUSHMARK (SP);

	EXTEND (SP, 2);
	PUSHs (sv_2mortal (newSViv (*width)));
	PUSHs (sv_2mortal (newSViv (*height)));

	PUTBACK;

	count = call_sv (callback->func, G_ARRAY);

	SPAGAIN;

	if (count != 2)
		croak ("a size callback must return two values, the width and the height");

	*width = POPi;
	*height = POPi;

	PUTBACK;
	FREETMPS;
	LEAVE;
}

/* ------------------------------------------------------------------------- */

MODULE = Gnome2::Rsvg	PACKAGE = Gnome2::Rsvg	PREFIX = rsvg_

=for object Gnome2::Rsvg::main

=cut

BOOT:
#include "register.xsh"
#include "boot.xsh"

void
GET_VERSION_INFO (class)
    PPCODE:
	EXTEND (SP, 3);
	PUSHs (sv_2mortal (newSViv (LIBRSVG_MAJOR_VERSION)));
	PUSHs (sv_2mortal (newSViv (LIBRSVG_MINOR_VERSION)));
	PUSHs (sv_2mortal (newSViv (LIBRSVG_MICRO_VERSION)));
	PERL_UNUSED_VAR (ax);

bool
CHECK_VERSION (class, major, minor, micro)
	int major
	int minor
	int micro
    CODE:
	RETVAL = LIBRSVG_CHECK_VERSION (major, minor, micro);
    OUTPUT:
	RETVAL

##  GQuark rsvg_error_quark (void) G_GNUC_CONST

=for apidoc __gerror__
=cut
##  GdkPixbuf *rsvg_pixbuf_from_file (const gchar *file_name, GError **error)
GdkPixbuf_noinc *
rsvg_pixbuf_from_file (class, file_name)
	const gchar *file_name
    PREINIT:
        GError *error = NULL;
    CODE:
	RETVAL = rsvg_pixbuf_from_file (file_name, &error);
        if (error)
		gperl_croak_gerror (file_name, error);
    OUTPUT:
	RETVAL

=for apidoc __gerror__
=cut
##  GdkPixbuf *rsvg_pixbuf_from_file_at_zoom (const gchar *file_name, double x_zoom, double y_zoom, GError **error)
GdkPixbuf_noinc *
rsvg_pixbuf_from_file_at_zoom (class, file_name, x_zoom, y_zoom)
	const gchar *file_name
	double x_zoom
	double y_zoom
    PREINIT:
        GError *error = NULL;
    CODE:
	RETVAL = rsvg_pixbuf_from_file_at_zoom (file_name, x_zoom, y_zoom, &error);
        if (error)
		gperl_croak_gerror (file_name, error);
    OUTPUT:
	RETVAL

=for apidoc __gerror__
=cut
##  GdkPixbuf *rsvg_pixbuf_from_file_at_size (const gchar *file_name, gint width, gint height, GError **error)
GdkPixbuf_noinc *
rsvg_pixbuf_from_file_at_size (class, file_name, width, height)
	const gchar *file_name
	gint width
	gint height
    PREINIT:
        GError *error = NULL;
    CODE:
	RETVAL = rsvg_pixbuf_from_file_at_size (file_name, width, height, &error);
        if (error)
		gperl_croak_gerror (file_name, error);
    OUTPUT:
	RETVAL

=for apidoc __gerror__
=cut
##  GdkPixbuf *rsvg_pixbuf_from_file_at_max_size (const gchar *file_name, gint max_width, gint max_height, GError **error)
GdkPixbuf_noinc *
rsvg_pixbuf_from_file_at_max_size (class, file_name, max_width, max_height)
	const gchar *file_name
	gint max_width
	gint max_height
    PREINIT:
        GError *error = NULL;
    CODE:
	RETVAL = rsvg_pixbuf_from_file_at_max_size (file_name, max_width, max_height, &error);
        if (error)
		gperl_croak_gerror (file_name, error);
    OUTPUT:
	RETVAL

=for apidoc __gerror__
=cut
##  GdkPixbuf *rsvg_pixbuf_from_file_at_zoom_with_max (const gchar *file_name, double x_zoom, double y_zoom, gint max_width, gint max_height, GError **error)
GdkPixbuf_noinc *
rsvg_pixbuf_from_file_at_zoom_with_max (class, file_name, x_zoom, y_zoom, max_width, max_height)
	const gchar *file_name
	double x_zoom
	double y_zoom
	gint max_width
	gint max_height
    PREINIT:
        GError *error = NULL;
    CODE:
	RETVAL = rsvg_pixbuf_from_file_at_zoom_with_max (file_name, x_zoom, y_zoom, max_width, max_height, &error);
        if (error)
		gperl_croak_gerror (file_name, error);
    OUTPUT:
	RETVAL

##  void rsvg_set_default_dpi (double dpi,)
void
rsvg_set_default_dpi (class, dpi)
	double dpi
    C_ARGS:
	dpi

MODULE = Gnome2::Rsvg	PACKAGE = Gnome2::Rsvg::Handle	PREFIX = rsvg_handle_

##  RsvgHandle *rsvg_handle_new (void)
RsvgHandle *
rsvg_handle_new (class)
    C_ARGS:
	/* void */

void
DESTROY (handle)
	RsvgHandle *handle
    CODE:
	rsvg_handle_free (handle);

##  void rsvg_handle_set_size_callback (RsvgHandle *handle, RsvgSizeFunc size_func, gpointer user_data, GDestroyNotify user_data_destroy)
void
rsvg_handle_set_size_callback (handle, size_func, user_data=NULL)
	RsvgHandle *handle
	SV *size_func
	SV *user_data
    PREINIT:
	GPerlCallback *callback;
    CODE:
	callback = rsvg2perl_size_func_create (size_func, user_data);
	rsvg_handle_set_size_callback (handle,
	                               (RsvgSizeFunc) rsvg2perl_size_func,
	                               callback,
	                               (GDestroyNotify) gperl_callback_destroy);

=for apidoc __gerror__
=cut
##  gboolean rsvg_handle_write (RsvgHandle *handle, const guchar *buf, gsize count, GError **error)
gboolean
rsvg_handle_write (handle, data)
	RsvgHandle *handle
	SV *data
    PREINIT:
	const guchar *buf = NULL;
	STRLEN len;
        GError *error = NULL;
    CODE:
	buf = (const guchar *) SvPV (data, len);
	RETVAL = rsvg_handle_write (handle, buf, len, &error);
        if (error)
		gperl_croak_gerror (NULL, error);
    OUTPUT:
	RETVAL

=for apidoc __gerror__
=cut
##  gboolean rsvg_handle_close (RsvgHandle *handle, GError **error)
gboolean
rsvg_handle_close (handle)
	RsvgHandle *handle
    PREINIT:
        GError *error = NULL;
    CODE:
	RETVAL = rsvg_handle_close (handle, &error);
        if (error)
		gperl_croak_gerror (NULL, error);
    OUTPUT:
	RETVAL

##  GdkPixbuf *rsvg_handle_get_pixbuf (RsvgHandle *handle)
GdkPixbuf_noinc *
rsvg_handle_get_pixbuf (handle)
	RsvgHandle *handle

#if LIBRSVG_CHECK_VERSION (2, 4, 0)

##  G_CONST_RETURN char* rsvg_handle_get_title (RsvgHandle *handle)
const char*
rsvg_handle_get_title (handle)
	RsvgHandle *handle

##  G_CONST_RETURN char* rsvg_handle_get_desc (RsvgHandle *handle)
const char*
rsvg_handle_get_desc (handle)
	RsvgHandle *handle

#endif /* 2.4.0 */

##  void rsvg_handle_set_dpi (RsvgHandle *handle, double dpi)
void
rsvg_handle_set_dpi (handle, dpi)
	RsvgHandle *handle
	double dpi

#if LIBRSVG_CHECK_VERSION (2, 10, 0)

##  void rsvg_handle_set_base_uri (RsvgHandle *handle, const char *base_uri)
void
rsvg_handle_set_base_uri (handle, base_uri)
	RsvgHandle *handle
	const char *base_uri

##  const char * rsvg_handle_get_base_uri (RsvgHandle *handle)
const char_ornull *
rsvg_handle_get_base_uri (handle)
	RsvgHandle *handle

##  const char * rsvg_handle_get_metadata (RsvgHandle *handle)
const char_ornull *
rsvg_handle_get_metadata (handle)
	RsvgHandle *handle

#endif /* 2.10.0 */

#if LIBRSVG_CHECK_VERSION (2, 14, 0)

void rsvg_handle_render_cairo (RsvgHandle *handle, cairo_t *cr);

void rsvg_handle_render_cairo_sub(RsvgHandle *handle, cairo_t *cr, const char * id);

#endif
