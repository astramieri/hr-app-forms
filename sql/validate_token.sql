create or replace function hr.validate_token
    return boolean 
is    
    v_x01 varchar2(32767);
    
    v_jwt apex_jwt.t_token;
    
    v_jwt_user varchar2(255);
begin
    v_x01 := v('APP_AJAX_X01');

    if v_x01 like '%.%.%' then
        v_jwt := apex_jwt.decode (
            p_value         => v_x01,
            p_signature_key => sys.utl_raw.cast_to_raw('my-secret-key')
        );
                    
        apex_jwt.validate (
            p_token => v_jwt,
            p_iss   => 'FORMS',
            p_aud   => 'APEX'
        );

        apex_json.parse (p_source => v_jwt.payload );
        
        v_jwt_user := apex_json.get_varchar2('sub');
    end if;
    
    if apex_authentication.is_public_user then
        if v_jwt_user is not null then
            apex_authentication.post_login(p_username => v_jwt_user);
            
            apex_acl.replace_user_roles (
                p_application_id => 100, -- TOFIX
                p_user_name      => v_jwt_user,
                p_role_ids       => apex_t_number('5975716574509514')
            );
        else
            return false;
        end if;
    elsif apex_application.g_user <> v_jwt_user then
        return false;
    end if;

    return true;
exception 
    when others then
        return false;
end validate_token;
/