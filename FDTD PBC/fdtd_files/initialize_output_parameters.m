disp('initializing the output parameters');

number_of_sampled_electric_fields  = 0;
number_of_sampled_magnetic_fields  = 0;
number_of_sampled_voltages  = 0;
number_of_sampled_currents  = 0;
number_of_ports = 0;

if exist('sampled_electric_fields','var')
    number_of_sampled_electric_fields  = size(sampled_electric_fields,2);
end
if exist('sampled_magnetic_fields','var')
    number_of_sampled_magnetic_fields  = size(sampled_magnetic_fields,2);
end
if exist('sampled_voltages','var')
    number_of_sampled_voltages  = size(sampled_voltages,2);
end
if exist('sampled_currents','var')
    number_of_sampled_currents  = size(sampled_currents,2);
end
if exist('ports','var')
    number_of_ports = size(ports,2);
end

% intialize frequency domain parameters
frequency_domain.frequencies = [frequency_domain.start: ...
    frequency_domain.step:frequency_domain.end];
frequency_domain.number_of_frequencies = ...
    size(frequency_domain.frequencies,2);

% initialize sampled electric field terms
for ind=1:number_of_sampled_electric_fields  
    is = round((sampled_electric_fields(ind).x - fdtd_domain.min_x)/dx)+1;
    js = round((sampled_electric_fields(ind).y - fdtd_domain.min_y)/dy)+1;
    ks = round((sampled_electric_fields(ind).z - fdtd_domain.min_z)/dz)+1;
    sampled_electric_fields(ind).is = is;
    sampled_electric_fields(ind).js = js;
    sampled_electric_fields(ind).ks = ks;
    sampled_electric_fields(ind).sampled_value = ...
        zeros(1, number_of_time_steps);
    sampled_electric_fields(ind).time = ([1:number_of_time_steps])*dt;
end

% initialize sampled magnetic field terms
for ind=1:number_of_sampled_magnetic_fields  
    is = round((sampled_magnetic_fields(ind).x - fdtd_domain.min_x)/dx)+1;
    js = round((sampled_magnetic_fields(ind).y - fdtd_domain.min_y)/dy)+1;
    ks = round((sampled_magnetic_fields(ind).z - fdtd_domain.min_z)/dz)+1;
    sampled_magnetic_fields(ind).is = is;
    sampled_magnetic_fields(ind).js = js;
    sampled_magnetic_fields(ind).ks = ks;
    sampled_magnetic_fields(ind).sampled_value = ...
        zeros(1, number_of_time_steps);
    sampled_magnetic_fields(ind).time = ([1:number_of_time_steps]-0.5)*dt;
end

% initialize sampled voltage terms
for ind=1:number_of_sampled_voltages  
    
    node_indices = get_node_indices(sampled_voltages(ind), fdtd_domain);
    is = node_indices.is; js = node_indices.js; ks = node_indices.ks; 
    ie = node_indices.ie; je = node_indices.je; ke = node_indices.ke; 
    sampled_voltages(ind).node_indices = node_indices;
    
    sampled_voltages(ind).sampled_value = ...
                        zeros(1, number_of_time_steps);

    switch (sampled_voltages(ind).direction(1))
    case 'x'
        fi = create_linear_index_list(Ex,is:ie-1,js:je,ks:ke);
        sampled_voltages(ind).Csvf = -dx/((je-js+1)*(ke-ks+1));
    case 'y'
        fi = create_linear_index_list(Ey,is:ie,js:je-1,ks:ke);
        sampled_voltages(ind).Csvf = -dy/((ke-ks+1)*(ie-is+1));
    case 'z'
        fi = create_linear_index_list(Ez,is:ie,js:je,ks:ke-1);
        sampled_voltages(ind).Csvf = -dz/((ie-is+1)*(je-js+1));
    end    
    if strcmp(sampled_voltages(ind).direction(2),'n')
        sampled_voltages(ind).Csvf =  -1 * sampled_voltages(ind).Csvf;
    end
    sampled_voltages(ind).field_indices = fi;
    sampled_voltages(ind).time = ([1:number_of_time_steps])*dt;
end

% initialize sampled current terms
for ind=1:number_of_sampled_currents  
    node_indices = get_node_indices(sampled_currents(ind), fdtd_domain);
    is = node_indices.is; js = node_indices.js; ks = node_indices.ks; 
    ie = node_indices.ie; je = node_indices.je; ke = node_indices.ke; 
    sampled_currents(ind).node_indices = node_indices;

    sampled_currents(ind).sampled_value = ...
                        zeros(1, number_of_time_steps);
    sampled_currents(ind).time =([1:number_of_time_steps]-0.5)*dt;
    
    switch (sampled_currents(ind).direction(1))
    case 'x'
        if (is==ie) 
            sampled_currents(ind).node_indices.is = sampled_currents(ind).node_indices.is - 1;
            sampled_currents(ind).node_indices.ie = sampled_currents(ind).node_indices.ie + 1;
        end
        sampled_currents(ind).Cscf = 1/(sampled_currents(ind).node_indices.ie-sampled_currents(ind).node_indices.is);
    case 'y'
        if (js==je)
            sampled_currents(ind).node_indices.js = sampled_currents(ind).node_indices.js - 1;
            sampled_currents(ind).node_indices.je = sampled_currents(ind).node_indices.je + 1;
        end 
        sampled_currents(ind).Cscf = 1/(sampled_currents(ind).node_indices.je-sampled_currents(ind).node_indices.js);
    case 'z'
        if (ks==ke) 
            sampled_currents(ind).node_indices.ks = sampled_currents(ind).node_indices.ks - 1;
            sampled_currents(ind).node_indices.ke = sampled_currents(ind).node_indices.ke + 1;
        end
        sampled_currents(ind).Cscf = 1/(sampled_currents(ind).node_indices.ke-sampled_currents(ind).node_indices.ks);
    end
    if strcmp(sampled_currents(ind).direction(2),'n')
        sampled_currents(ind).Cscf = -1 * sampled_currents(ind).Cscf;
    end    
end
