create or replace function hr.generate_token (p_user_name in varchar2) 
    return varchar2 
is    
    v_jwt varchar2(32767); 
begin
    v_jwt := apex_jwt.encode (
        p_iss           => 'FORMS',
        p_aud           => 'APEX',
        p_sub           => p_user_name,
        p_exp_sec       => 60, -- 60 second
        --p_other_claims  => '"P1_PARM":"somevalue"', -- TOFIX
        p_signature_key => utl_raw.cast_to_raw('my-secret-key') -- TOFIX
    );

    return v_jwt;
end generate_token;
/