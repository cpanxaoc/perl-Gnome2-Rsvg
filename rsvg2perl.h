/*
 * Copyright (C) 2003 by the gtk2-perl team
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
 *
 * $Header$
 */

#ifndef _RSVG2PERL_H_
#define _RSVG2PERL_H_

#include <gtk2perl.h>
#include <librsvg/rsvg.h>
#include <librsvg/rsvg-gz.h>

#include "rsvg2perl-gtypes.h"
#include "rsvg2perl-version.h"

#define RSVG2PERL_TYPE_RSVG_HANDLE (rsvg2perl_rsvg_handle_get_type ())
GType rsvg2perl_rsvg_handle_get_type (void) G_GNUC_CONST;

#include "rsvg2perl-autogen.h"

#endif /* _RSVG2PERL_H_ */
