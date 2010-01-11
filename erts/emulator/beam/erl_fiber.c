/*
 * %CopyrightBegin%
 * 
 * Copyright Ericsson AB 1996-2009. All Rights Reserved.
 * 
 * The contents of this file are subject to the Erlang Public License,
 * Version 1.1, (the "License"); you may not use this file except in
 * compliance with the License. You should have received a copy of the
 * Erlang Public License along with this software. If not, it can be
 * retrieved online at http://www.erlang.org/.
 * 
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
 * the License for the specific language governing rights and limitations
 * under the License.
 * 
 * %CopyrightEnd%
 */

#ifdef HAVE_CONFIG_H
#  include "config.h"
#endif

#include <stddef.h> /* offsetof() */
#include "sys.h"
#include "erl_vm.h"
#include "erl_sys_driver.h"
#include "global.h"
#include "erl_process.h"
#include "error.h"
#include "bif.h"
#include "big.h"
#include "dist.h"
#include "erl_version.h"
#include "erl_binary.h"
#include "beam_bp.h"
#include "erl_db_util.h"
#include "register.h"

#if defined(SEPARATE_STACK) && defined(FIBER)

// fiber:create(Mod,Fun,Args) -> ID
BIF_RETTYPE fiber_create_3(BIF_ALIST_3)
{
    ErlFiber* fiber = erl_fiber_create(BIF_P, BIF_ARG_1, BIF_ARG_2, BIF_ARG_3);
    if (!fiber)
	BIF_ERROR(BIF_P, BADARG);
    erl_fiber_enq(BIF_P, fiber);
    BIF_RET(fiber->id);
}

#define FIBER_ERROR(p,r) \
    do {		      \
	(p)->freason = (r);   \
	return THE_NON_VALUE; \
    } while(0)

#define FIBER_SWITCH(p, f) \
    do {						\
	(p)->arity = 0;					\
	(p)->def_arg_reg[3] = (Eterm) (f);		\
	(p)->freason = SWITCH;				\
	return THE_NON_VALUE;				\
    } while (0)

// fiber:yield() run next runable fiber
Eterm fiber_yield_0(BIF_ALIST_0)
{
    ErlFiber* fiber = BIF_P->fiber_hd->next;
    if (fiber) {
	FIBER_SWITCH(BIF_P, fiber);
    }
    return BIF_P->fiber_hd->id;
}

// fiber:yield(ID)  throw true
Eterm fiber_yield_1(BIF_ALIST_1)
{
    ErlFiber* fiber;
    if (!(is_pid(BIF_ARG_1) || is_internal_ref(BIF_ARG_1)))
	FIBER_ERROR(BIF_P, BADARG);
    if (!(fiber = erl_fiber_find(BIF_P, BIF_ARG_1)))
	FIBER_ERROR(BIF_P, BADARG);
    if (fiber != BIF_P->fiber_hd) {
	FIBER_SWITCH(BIF_P, fiber);
    }
    return BIF_P->fiber_hd->id;
}

// fiber:exit(Reason)
// terminate execting fiber switch to next
//
Eterm fiber_exit_1(BIF_ALIST_1)
{
    ErlFiber* fiber = BIF_P->fiber_hd->next;
    if (!fiber)
	return exit_1(BIF_P,BIF_ARG_1);
    else {
	FIBER_SWITCH(BIF_P, fiber);
    }
}

// fiber:exit(ID,Reason)
Eterm fiber_exit_2(BIF_ALIST_2)
{
    ErlFiber* fiber;

    if (!(is_internal_ref(BIF_ARG_1) || is_pid(BIF_ARG_1)))
	FIBER_ERROR(BIF_P, BADARG);
    if (!(fiber = erl_fiber_find(BIF_P, BIF_ARG_1)))
	FIBER_ERROR(BIF_P, BADARG);
    if (fiber == BIF_P->fiber_hd)
	return fiber_exit_1(BIF_P, BIF_ARG_2);
    else {
	// should we handle Reason somehow ?
	erl_fiber_delete(BIF_P, fiber);
	return am_true;
    }
}

// erlang:fibers()
// return a list of fibers in current process
Eterm fibers_0(BIF_ALIST_0)
{
    Eterm *hp = HAlloc(BIF_P, 2*BIF_P->nfibers);
    Eterm res = NIL;
    ErlFiber* fp;

    for (fp = BIF_P->fiber_tl; fp; fp = fp->prev) {
	res = CONS(hp, fp->id, res);
	hp += 2;
    }
    BIF_RET(res);
}

// Return current fiber id
Eterm fiber_0(BIF_ALIST_0)
{
    BIF_RET(BIF_P->fiber_hd->id);
}

#endif
