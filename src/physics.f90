module physics
    use iso_fortran_env, only: real64
    use grid, only: grid_type
    implicit none 
    private
    public :: step_heat

contains
    
    pure subroutine step_heat(old_grid, new_grid, alpha, dx, dy, dt)
        type(grid_type), intent(in) :: old_grid
        type(grid_type), intent(inout) :: new_grid
        real(real64), intent(in) :: alpha, dx, dy, dt 

        integer :: i, j
        real(real64) :: rx, ry

        rx = alpha * dt / (dx * dx)
        ry = alpha * dt / (dy * dy)

        if (rx + ry > 0.5_real64) then
            error stop "Unstable time step"
        end if

        new_grid%temp(1,:) = old_grid%temp(1,:)
        new_grid%temp(old_grid%nx,:) = old_grid%temp(old_grid%nx,:)

        new_grid%temp(:,1) = old_grid%temp(:,1)
        new_grid%temp(:,old_grid%ny) = old_grid%temp(:,old_grid%ny)

        do concurrent (i = 2:old_grid%nx-1, j = 2:old_grid%ny-1)
            new_grid%temp(i,j) = old_grid%temp(i,j) + &
                rx * ( old_grid%temp(i+1,j) &
                     - 2.0_real64*old_grid%temp(i,j) &
                     + old_grid%temp(i-1,j) ) + &
                ry * ( old_grid%temp(i,j+1) &
                     - 2.0_real64*old_grid%temp(i,j) &
                     + old_grid%temp(i,j-1) )
        end do
    
    end subroutine step_heat

end module physics