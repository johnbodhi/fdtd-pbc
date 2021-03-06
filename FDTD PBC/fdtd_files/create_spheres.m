disp('creating spheres');

cx = fdtd_domain.cell_center_x;
cy = fdtd_domain.cell_center_y;
cz = fdtd_domain.cell_center_z;

for ind=1:number_of_spheres
% distance of the centers of the cells from the center of the sphere
    distance = sqrt((spheres(ind).center_x - cx).^2 ...
            + (spheres(ind).center_y - cy).^2 ...
            + (spheres(ind).center_z - cz).^2);
    I = find(distance<=spheres(ind).radius);
    material_3d_space(I) = spheres(ind).material_type;
end
clear cx cy cz;
