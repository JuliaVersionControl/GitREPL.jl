using GitRepl
using Documenter

DocMeta.setdocmeta!(GitRepl, :DocTestSetup, :(using GitRepl); recursive=true)

makedocs(;
    modules=[GitRepl],
    authors="Dilum Aluthge and contributors",
    repo="https://github.com/JuliaVersionControl/GitRepl.jl/blob/{commit}{path}#{line}",
    sitename="GitRepl.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaVersionControl.github.io/GitRepl.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
    strict=true,
)

deploydocs(;
    repo="github.com/JuliaVersionControl/GitRepl.jl",
    devbranch="main",
)
