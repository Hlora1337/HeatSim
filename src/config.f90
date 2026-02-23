    module config
        use iso_fortran_env, only: real64
        implicit none
        private
        public :: sim_params, load_parameters

        type :: sim_params
            integer :: nx
            integer :: ny
            integer :: steps
            real(real64) :: center_temp
        end type sim_params

    contains

        subroutine load_parameters(params)
            type(sim_params), intent(out) :: params
            integer :: nargs

            nargs = command_argument_count()

            if (nargs >= 4) then
                call read_from_cli(params)
            else
                call read_from_file("input.txt", params)
            end if
        end subroutine load_parameters

        subroutine read_from_cli(params)
            type(sim_params), intent(out) :: params
            character(len=32) :: arg

            call get_command_argument(1, arg)
            read(arg,*) params%nx

            call get_command_argument(2, arg)
            read(arg,*) params%ny

            call get_command_argument(3, arg)
            read(arg,*) params%steps

            call get_command_argument(4, arg)
            read(arg,*) params%center_temp
        end subroutine read_from_cli

        subroutine read_from_file(filename, params)
            character(len=*), intent(in) :: filename
            type(sim_params), intent(out) :: params

            integer :: unit
            character(len=256) :: line, key
            real(real64) :: rval
            integer :: pos

            open(newunit=unit, file=filename, status="old")

            do
                read(unit,'(A)',end=100) line
                pos = index(line, "=")
                if (pos <= 0) cycle

                key = adjustl(line(1:pos-1))
                read(line(pos+1:),*) rval

                select case (trim(key))
                case("nx")
                    params%nx = int(rval)
                case("ny")
                    params%ny = int(rval)
                case("steps")
                    params%steps = int(rval)
                case("center_temp")
                    params%center_temp = rval
                end select
            end do
    100     close(unit)
        end subroutine read_from_file

    end module config