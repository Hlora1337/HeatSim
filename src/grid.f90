module grid
    use iso_fortran_env, only: real64
    implicit none
    private
    public :: grid_type, init_grid

    type :: grid_type
        integer :: nx
        integer :: ny
        real(real64), allocatable :: temp(:,:)
    end type grid_type

contains

    subroutine init_grid(g, nx, ny, center_temp)
        type(grid_type), intent(out) :: g
        integer, intent(in) :: nx, ny
        real(real64), intent(in) :: center_temp

        g%nx = nx
        g%ny = ny

        allocate(g%temp(nx, ny))

        g%temp = 0.0_real64

        g%temp(nx/2, ny/2) = center_temp

    end subroutine init_grid

end module grid