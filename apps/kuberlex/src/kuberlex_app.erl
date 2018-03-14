%%%-------------------------------------------------------------------
%% @doc kuberlex public API
%% @end
%%%-------------------------------------------------------------------

-module(kuberlex_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Host = os:getenv("HOST"),
    Token = list_to_binary(os:getenv("TOKEN")),
    Cfg0 = kuberl:cfg_with_host(Host),
    Cfg = kuberl:cfg_with_bearer_token(Cfg0, Token),
    io:format("~p~n", [kuberl_core_api:get_api_versions(ctx:background(), #{cfg => Cfg})]),
    timer:sleep(20000).

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
