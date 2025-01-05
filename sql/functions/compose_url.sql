create or replace function compose_url (
    p_user   in varchar2,
    p_page   in varchar2,
    p_params in varchar2 default null,
    p_values in varchar2 default null
)
    return varchar2
is
    v_jwt varchar2(1000);
    v_url varchar2(1000);
    
    v_apex apex%rowtype;
begin
	v_jwt := generate_token(p_user, p_params, p_values);

    select a.*
      into v_apex
      from apex a;

    -- FRIENDLY
	-- <protocol>://<hostname>:<port>/ords/r/<workspace>/<application>/<page>?request=<request>&x01=<token>

	v_url := v_url || v_apex.protocol || '://' || v_apex.hostname;
    
    if v_apex.port is not null then
        v_url := v_url || ':' || v_apex.port;
    end if;
    
    v_url := v_url || '/ords/r/' || v_apex.workspace;
    
    v_url := v_url || '/' || v_apex.application;
    
	v_url := v_url || '/' || p_page;
    
    v_url := v_url|| '?request=APEX_AUTHENTICATION=JWT';
    
    v_url := v_url || chr(38) || 'x01=' || v_jwt;

    return v_url;
end compose_url;