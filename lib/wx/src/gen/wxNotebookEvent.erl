%%
%% %CopyrightBegin%
%% 
%% Copyright Ericsson AB 2008-2009. All Rights Reserved.
%% 
%% The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved online at http://www.erlang.org/.
%% 
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
%% 
%% %CopyrightEnd%
%% This file is generated DO NOT EDIT

%% @doc See external documentation: <a href="http://www.wxwidgets.org/manuals/stable/wx_wxnotebookevent.html">wxNotebookEvent</a>.
%% <dl><dt>Use {@link wxEvtHandler:connect/3.} with EventType:</dt>
%% <dd><em>command_notebook_page_changed</em>, <em>command_notebook_page_changing</em></dd></dl>
%% See also the message variant {@link wxEvtHandler:wxNotebook(). #wxNotebook{}} event record type.
%%
%% <p>This class is derived (and can use functions) from: 
%% <br />{@link wxNotifyEvent}
%% <br />{@link wxCommandEvent}
%% <br />{@link wxEvent}
%% </p>
%% @type wxNotebookEvent().  An object reference, The representation is internal
%% and can be changed without notice. It can't be used for comparsion
%% stored on disc or distributed for use on other nodes.

-module(wxNotebookEvent).
-include("wxe.hrl").
-export([getOldSelection/1,getSelection/1,setOldSelection/2,setSelection/2]).

%% inherited exports
-export([allow/1,getClientData/1,getExtraLong/1,getId/1,getInt/1,getSkipped/1,
  getString/1,getTimestamp/1,isAllowed/1,isChecked/1,isCommandEvent/1,
  isSelection/1,parent_class/1,resumePropagation/2,setInt/2,setString/2,
  shouldPropagate/1,skip/1,skip/2,stopPropagation/1,veto/1]).

%% @hidden
parent_class(wxNotifyEvent) -> true;
parent_class(wxCommandEvent) -> true;
parent_class(wxEvent) -> true;
parent_class(_Class) -> erlang:error({badtype, ?MODULE}).

%% @spec (This::wxNotebookEvent()) -> integer()
%% @doc See <a href="http://www.wxwidgets.org/manuals/stable/wx_wxnotebookevent.html#wxnotebookeventgetoldselection">external documentation</a>.
getOldSelection(#wx_ref{type=ThisT,ref=ThisRef}) ->
  ?CLASS(ThisT,wxNotebookEvent),
  wxe_util:call(?wxNotebookEvent_GetOldSelection,
  <<ThisRef:32/?UI>>).

%% @spec (This::wxNotebookEvent()) -> integer()
%% @doc See <a href="http://www.wxwidgets.org/manuals/stable/wx_wxnotebookevent.html#wxnotebookeventgetselection">external documentation</a>.
getSelection(#wx_ref{type=ThisT,ref=ThisRef}) ->
  ?CLASS(ThisT,wxNotebookEvent),
  wxe_util:call(?wxNotebookEvent_GetSelection,
  <<ThisRef:32/?UI>>).

%% @spec (This::wxNotebookEvent(), NOldSel::integer()) -> ok
%% @doc See <a href="http://www.wxwidgets.org/manuals/stable/wx_wxnotebookevent.html#wxnotebookeventsetoldselection">external documentation</a>.
setOldSelection(#wx_ref{type=ThisT,ref=ThisRef},NOldSel)
 when is_integer(NOldSel) ->
  ?CLASS(ThisT,wxNotebookEvent),
  wxe_util:cast(?wxNotebookEvent_SetOldSelection,
  <<ThisRef:32/?UI,NOldSel:32/?UI>>).

%% @spec (This::wxNotebookEvent(), NSel::integer()) -> ok
%% @doc See <a href="http://www.wxwidgets.org/manuals/stable/wx_wxnotebookevent.html#wxnotebookeventsetselection">external documentation</a>.
setSelection(#wx_ref{type=ThisT,ref=ThisRef},NSel)
 when is_integer(NSel) ->
  ?CLASS(ThisT,wxNotebookEvent),
  wxe_util:cast(?wxNotebookEvent_SetSelection,
  <<ThisRef:32/?UI,NSel:32/?UI>>).

 %% From wxNotifyEvent 
%% @hidden
veto(This) -> wxNotifyEvent:veto(This).
%% @hidden
isAllowed(This) -> wxNotifyEvent:isAllowed(This).
%% @hidden
allow(This) -> wxNotifyEvent:allow(This).
 %% From wxCommandEvent 
%% @hidden
setString(This,S) -> wxCommandEvent:setString(This,S).
%% @hidden
setInt(This,I) -> wxCommandEvent:setInt(This,I).
%% @hidden
isSelection(This) -> wxCommandEvent:isSelection(This).
%% @hidden
isChecked(This) -> wxCommandEvent:isChecked(This).
%% @hidden
getString(This) -> wxCommandEvent:getString(This).
%% @hidden
getInt(This) -> wxCommandEvent:getInt(This).
%% @hidden
getExtraLong(This) -> wxCommandEvent:getExtraLong(This).
%% @hidden
getClientData(This) -> wxCommandEvent:getClientData(This).
 %% From wxEvent 
%% @hidden
stopPropagation(This) -> wxEvent:stopPropagation(This).
%% @hidden
skip(This, Options) -> wxEvent:skip(This, Options).
%% @hidden
skip(This) -> wxEvent:skip(This).
%% @hidden
shouldPropagate(This) -> wxEvent:shouldPropagate(This).
%% @hidden
resumePropagation(This,PropagationLevel) -> wxEvent:resumePropagation(This,PropagationLevel).
%% @hidden
isCommandEvent(This) -> wxEvent:isCommandEvent(This).
%% @hidden
getTimestamp(This) -> wxEvent:getTimestamp(This).
%% @hidden
getSkipped(This) -> wxEvent:getSkipped(This).
%% @hidden
getId(This) -> wxEvent:getId(This).
