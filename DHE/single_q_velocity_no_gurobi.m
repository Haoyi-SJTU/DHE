function vel = single_q_velocity_new(q_previous, q_now, delta_t, q_vel_previous)
    delta_q = q_now - q_previous;
    
    Q = [0, 0, 0, 0;
         0, 8*delta_t^2+1, 4*delta_t^3, 0;
         0, 4*delta_t^3, 2*delta_t^4+8*delta_t^2, -8*delta_t;
         0, 0, -8*delta_t, 8];
     
    c = [0; 
        -16*delta_t*delta_q - 2*q_vel_previous; 
        -8*delta_q*delta_t^2; 
        0];
        
    A = [1, -1,  0,       -1; 
         0,  0, delta_t, -1];
         
    b = [0; 0];
    
    KKT_matrix = [Q, A'; 
                  A, zeros(2, 2)];
                  
    rhs_vector = [-c; b];
    
    sol = KKT_matrix \ rhs_vector;
    
    vel = sol(1);
end