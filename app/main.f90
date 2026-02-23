program heat_simulator
    use iso_fortran_env, only: real64
    use grid
    use physics
    use io
    use config
    implicit none

    type(sim_params) :: params

    type(grid_type), target :: grid_a, grid_b
    type(grid_type), pointer :: current, next, tmp

    integer :: step
    real(real64) :: max_temp

    ! Физические параметры фиксированы
    real(real64), parameter :: alpha = 0.1_real64
    real(real64), parameter :: dx    = 0.01_real64
    real(real64), parameter :: dy    = 0.01_real64
    real(real64), parameter :: dt    = 0.0002_real64

    call load_parameters(params)

    call init_grid(grid_a, params%nx, params%ny, params%center_temp)
    call init_grid(grid_b, params%nx, params%ny, 0.0_real64)

    current => grid_a
    next    => grid_b

    do step = 1, params%steps

        call step_heat(current, next, alpha, dx, dy, dt)

        tmp     => current
        current => next
        next    => tmp

        if (mod(step,10) == 0) then
            max_temp = maxval(current%temp)

            write(*,'(A,I5,A,F10.3)') &
                "Step ", step, ": max_temp = ", max_temp

            call write_grid_to_file(current, "results.txt", step)
        end if

    end do

end program heat_simulator