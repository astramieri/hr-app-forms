create or replace function hr.validate_token
    return boolean 
is    
    v_x01 varchar2(32767);
    
    v_jwt apex_jwt.t_token;
    
    v_jwt_user varchar2(255);
    
    v_return boolean := false;
begin
    -- get the token from the url
    v_x01 := v('APP_AJAX_X01');

     -- check if the token has the jwt format xxx.xxx.xxx
    if v_x01 like '%.%.%' then
        -- decode the token
        v_jwt := apex_jwt.decode (
            p_value         => v_x01,
            p_signature_key => sys.utl_raw.cast_to_raw('my-secret-key')
        );
                    
        -- validate the token using the same issuer and audience values used to encrypt the token
        apex_jwt.validate (
            p_token => v_jwt,
            p_iss   => 'FORMS',
            p_aud   => 'APEX'
        );

        -- parse the payload 
        apex_json.parse (p_source => v_jwt.payload );
        
        -- get the username from the payload
        v_jwt_user := apex_json.get_varchar2('sub');
    end if;
    
     if apex_authentication.is_public_user then
        if v_jwt_user is not null then
            apex_authentication.post_login(p_username => v_jwt_user);

            v_return := true;
        end if;
    elsif apex_application.g_user <> v_jwt_user then
        return false;
    end if;

    return v_is_valid;
exception 
    when others then
        apex_debug.trace('---error---: %s', sqlerrm);
end validate_token;
/