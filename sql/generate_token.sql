create or replace function hr.generate_token (
    p_username in varchar2,
    p_role     in varchar2 
) 
    return varchar2 
is    
    v_jwt varchar2(32767); 
begin
    v_jwt := apex_jwt.encode (
        p_iss           => 'FORMS',
        p_aud           => 'APEX',
        p_sub           => p_username,
        p_exp_sec       => 60, -- 60 seconds
        p_other_claims  => '"role":' || apex_json.stringify(p_role),
        p_signature_key => utl_raw.cast_to_raw('my-secret-key') -- TOFIX
    );

    return v_jwt;
end generate_token;
/