create or replace function hr.validate_token
    return boolean 
is
    v_jwt apex_jwt.t_token;
    
    v_jwt_user varchar2(100);
    v_jwt_role varchar2(100);
    
    v_jwt_elts apex_t_varchar2;
    
    v_application_id pls_integer;
    v_page_id        pls_integer;
    
    v_session_id number;
    
    v_x01 varchar2(32767);
begin
    v_application_id := v('APP_ID');
    
    v_page_id := v('APP_PAGE_ID');
    
    v_x01 := v('APP_AJAX_X01');

    if v_x01 like '%.%.%' then
        v_jwt := apex_jwt.decode (
            p_value         => v_x01,
            p_signature_key => sys.utl_raw.cast_to_raw('my-secret-key'));
                    
        apex_jwt.validate (
            p_token => v_jwt,
            p_iss   => 'FORMS',
            p_aud   => 'APEX');

        apex_json.parse(p_source => v_jwt.payload);
        
        v_jwt_user := apex_json.get_varchar2('sub');
        
        v_jwt_elts := apex_json.get_members('.');
    end if;
    
    if apex_authentication.is_public_user then
        if v_jwt_user is not null then
            v_session_id := apex_custom_auth.get_session_id_from_cookie;
                        
            if v_session_id is not null then
                if not apex_custom_auth.is_session_valid then
                    v_session_id := apex_custom_auth.get_next_session_id;
                end if;
            else
                v_session_id := apex_custom_auth.get_next_session_id;
            end if;
            
            apex_custom_auth.post_login (
                p_uname       => v_jwt_user,
                p_session_id  => v_session_id,
                p_app_page    => v_application_id || ':' || v_page_id);
            
            for i in 1 .. v_jwt_elts.count 
            loop            
                if v_jwt_elts(i) like '%role%' then
                    apex_acl.replace_user_roles (
                        p_application_id  => v_application_id,
                        p_user_name       => v_jwt_user,
                        p_role_static_ids => apex_t_varchar2(apex_json.get_varchar2(v_jwt_elts(i))));   
                elsif upper(v_jwt_elts(i)) like 'P%' then
                    apex_util.set_session_state (
                        p_name  => upper(v_jwt_elts(i)),
                        p_value => apex_json.get_varchar2(v_jwt_elts(i)));
                end if;
            end loop;
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