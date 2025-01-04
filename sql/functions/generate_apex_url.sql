create or replace function generate_apex_url(
    p_user in varchar2,
    p_role in varchar2,
    p_page in varchar2
)
    return varchar2
is
    v_jwt varchar2(1000);
    v_url varchar2(1000);
    
    v_apex apex%rowtype;
begin
	v_jwt := generate_token(p_user, p_role);

    select a.*
      into v_apex
      from apex a;

    -- FRIENDLY
	-- <protocol>://<hostname>:<port>/ords/r/<workspace>/<application>/<page>?request=<request>&x01=<token>
	
	v_url := v_url || v_apex.protocol || '://' || v_apex.hostname || ':' || v_apex.port;
    v_url := v_url || '/ords/r/' || v_apex.workspace || '/' || v_apex.application;
	v_url := v_url || '/' || p_page || '?request=APEX_AUTHENTICATION=JWT';
    v_url := v_url || chr(38) || 'x01=' || v_jwt;

    return v_url;
end generate_apex_url;