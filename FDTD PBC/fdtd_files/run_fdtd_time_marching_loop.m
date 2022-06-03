disp (['Starting the time marching loop']);
disp(['Total number of time steps : ' ...
    num2str(number_of_time_steps)]); 

start_time = cputime; 
current_time = 0;

for time_step = 1:number_of_time_steps  
    update_incident_fields;
    update_magnetic_field_PBC_source;
    update_magnetic_fields;
    update_magnetic_field_CPML_ABC;
    
    update_electric_field_PBC_source;
    update_electric_fields;
    update_electric_field_CPML_ABC;
    update_electric_field_PBC_ABC;

    capture_fields_for_PBC;
    
    display_sampled_parameters;
end                                 

end_time = cputime;
total_time_in_minutes = (end_time - start_time)/60;
disp(['Total simulation time is ' ...
    num2str(total_time_in_minutes) ' minutes.']);
