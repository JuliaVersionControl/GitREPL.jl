# Some of the code in this file is taken from ReplMaker.jl (license: MIT)

fakeptys = abspath(joinpath(
    Sys.BINDIR, "..", "share", "julia", "test", "testhelpers", "FakePTYs.jl",
))

if isfile(fakeptys)
    Base.include(@__MODULE__, fakeptys)
    has_fakeptys = true
else
    @warn("FakePTYs.jl is not available", fakeptys)
    has_fakeptys = false
end

function run_fakepty_test(test_script)
    tty, pty = FakePTYs.open_fake_pty()
    # Start a julia process
    cmd = `$(Base.julia_cmd()) --project=$(Base.active_project()) --code-coverage=user --history-file=no --startup-file=no --compiled-modules=no`
    p = run(cmd, tty, tty, tty; wait=false)

    # Read until the prompt
    readuntil(pty, "julia>", keep=true)
    done = false
    repl_output_buffer = IOBuffer()

    # A task that just keeps reading the output
    @async begin
        while true
            done && break
            write(repl_output_buffer, readavailable(pty))
        end
    end

    # Execute our "script"
    for l in split(test_script, '\n'; keepempty=false)
        write(pty, l, '\n')
    end

    # Let the REPL exit
    write(pty, "exit()\n")
    wait(p)
    done = true

    # Gather the output
    repl_output = String(take!(repl_output_buffer))
    println(repl_output)
    return split(repl_output, '\n'; keepempty=false)
end
