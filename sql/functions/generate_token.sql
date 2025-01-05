create or replace function hr.generate_token (
    p_user   in varchar2,
    p_params in varchar2,
    p_values in varchar2 
) 
    return varchar2 
is    
    v_jwt varchar2(32767); 
    
    v_other_claims varchar2(1000);
    
    v_params apex_t_varchar2;
    v_values apex_t_varchar2;
begin
    v_params := apex_string.split(p_str => p_params, p_sep => ',');
    v_values := apex_string.split(p_str => p_values, p_sep => ',');
    
    for i in 1 .. v_params.count 
    loop
        if v_other_claims is not null then
            v_other_claims := v_other_claims || ',';
        end if;
    
        v_other_claims := '"' || v_params(i) || '"';
        v_other_claims := ':';
        v_other_claims := apex_json.stringify(v_values(i));
    end loop;

    v_jwt := apex_jwt.encode (
        p_iss           => 'FORMS',
        p_aud           => 'APEX',
        p_sub           => p_user,
        p_exp_sec       => 60 * 5, -- 5 minutes
        p_other_claims  => v_other_claims,
        p_signature_key => utl_raw.cast_to_raw('my-secret-key')
    );

    return v_jwt;
end generate_token;
/