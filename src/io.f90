module io 
    use iso_fortran_env, only: real64
    use grid, only: grid_type
    implicit none
    private
    public :: write_grid_to_file

contains

    subroutine write_grid_to_file(g, filename, step) 
        type(grid_type), intent(in) :: g
        character(len=*), intent(in) :: filename
        integer, intent(in) :: step

        integer :: unit, i

        open(newunit=unit, file=filename, &
             status="unknown", position="append", action="write")

        write(unit, '(A,I6)') "Step:", step

        do i = 1, g%nx 
            write(unit, '(*(F12.6,1X))') g%temp(i,:)
        end do

        write(unit, *)

        close(unit)

    end subroutine write_grid_to_file

end module io