# Some of the code in this file is taken from ReplMaker.jl (license: MIT)

@testset "Integration tests" begin
    if has_fakeptys
        CTRL_C = '\x03'

        @testset begin
            test_script = """
            import GitRepl

            GitRepl.gitrepl()
            """ * CTRL_C

            out = join(run_fakepty_test(test_script), '\n')
            @test occursin(r"REPL mode GitRepl.jl Git REPL mode initialized. Press , to enter and backspace to exit.", out)

        end

        @testset begin
            test_script = """
            import GitRepl

            GitRepl.gitrepl()

            ,--version
            """ * CTRL_C

            out = join(run_fakepty_test(test_script), '\n')
            @test occursin(r"git version", out)
        end

        @testset begin
            test_script = """
            import GitRepl

            GitRepl.gitrepl()

            ,--help
            """ * CTRL_C

            out = join(run_fakepty_test(test_script), '\n')
            @test occursin(r"usage: git", out)
        end
    else
        @warn("FakePTYs.jl is not available; skipping the integration tests.")
    end
end
